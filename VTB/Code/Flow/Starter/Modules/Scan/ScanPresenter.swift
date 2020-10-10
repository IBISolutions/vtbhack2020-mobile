//
//  ScanPresenter.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import CoreVideo
import Vision
import UIKit
import Service

protocol ScanControllerOutput: AnyObject {
    
    func viewDidLoad()
    func didCaptureFrame(with buffer: CVPixelBuffer)
    func didHandleShake()
    func didTapOnBackground()
}

enum ScanCoordinatorAction {
    case scanned
}

protocol ScanCoordinatorOutput: AnyObject {
    
    var onAction: Closure.Generic<ScanCoordinatorAction>? { get set }
}

enum ScanState {
    case capturing, found
}

final class ScanPresenter: ScanCoordinatorOutput {
    
    private enum Constants {
        static let carIdentifier = "car"
    }
    
    private lazy var request: VNCoreMLRequest? = {
        guard let visionModel = visionModel else {
            return nil
        }
        let request = VNCoreMLRequest(model: visionModel, completionHandler: visionRequestDidComplete)
        request.imageCropAndScaleOption = .scaleFill
        return request
    }()
    private var visionModel: VNCoreMLModel? = {
        guard let objectModel = try? YOLOv3Tiny(configuration: MLModelConfiguration()) else {
            return nil
        }
        return try? VNCoreMLModel(for: objectModel.model)
    }()
    
    private var state: ScanState = .capturing {
        didSet {
            view?.updateScanViewState(state)
        }
    }
    private var capturedBuffer: CVPixelBuffer?
    
    weak var view: ScanView?
    private let service = NetworkService()
    
    var onAction: Closure.Generic<ScanCoordinatorAction>?

    init(view: ScanView) {
        self.view = view
    }
    
    private func predictUsingVision(pixelBuffer: CVPixelBuffer) {
        guard let request = request else {
            fatalError()
        }
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer)
        try? handler.perform([request])
    }
    
    private func visionRequestDidComplete(request: VNRequest, error: Error?) {
        guard let predictions = request.results as? [VNRecognizedObjectObservation] else {
            return
        }
        let carPredictions = predictions
            .filter { $0.label == Constants.carIdentifier }
            .sorted { (first, second) -> Bool in
                guard let fConfidence = first.labels.first?.confidence,
                      let sConfidence = second.labels.first?.confidence else {
                    return false
                }
                return fConfidence > sConfidence
            }
        
        guard let goodPrediction = carPredictions.first,
              goodPrediction.labels.first?.confidence ?? .zero > 0.9 else {
            return
        }
        
        guard let buffer = capturedBuffer,
              let data = UIImage(ciImage: CIImage(cvPixelBuffer: buffer)).jpegData(compressionQuality: 0.95) else {
            return
        }
        let strBase64 = data.base64EncodedString()
        service.recognize(base64image: strBase64) {
            [weak self] res in
            
            if case .success(let predictions) = res {
                self?.findCarOnMarketplace(using: predictions.probabilities)
            }
        }
        
        DispatchQueue.main.async {
            self.state = .found
        }
    }
    
    private func findCarOnMarketplace(using probabilities: Probabilities) {
        guard let marketplace = AppData.shared.marketplace else {
            return
        }
        
        guard let max = (probabilities.allProbabilities.max {
            (f, s) -> Bool in
            
            f.1 > s.1
        }) else {
            return
        }
        guard let markList = (marketplace.list.filter { max.0.contains($0.title) }).first else {
            return
        }
        guard let model = (markList.models.filter { max.0.contains($0.title) }).first else {
            return
        }
        let name = String(format: "%@ %@", markList.title, model.title)
        let offers = String(format: "%d предложений от %d ₽", model.count, model.minPrice)
        view?.updateCarInfo(name: name, offers: offers)
    }
}

extension ScanPresenter: ScanControllerOutput {
    
    func viewDidLoad() {
        view?.initializeCapturing()
        view?.updateScanViewState(.capturing)
    }
    
    func didCaptureFrame(with buffer: CVPixelBuffer) {
        capturedBuffer = buffer
        predictUsingVision(pixelBuffer: buffer)
    }
    
    func didHandleShake() {
        if case .found = state {
            onAction?(.scanned)
        }
    }
    
    func didTapOnBackground() {
        state = .capturing
    }
}
