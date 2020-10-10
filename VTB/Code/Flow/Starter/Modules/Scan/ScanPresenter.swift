//
//  ScanPresenter.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import CoreVideo
import Vision

protocol ScanControllerOutput: AnyObject {
    
    func viewDidLoad()
    func didCaptureFrame(with buffer: CVPixelBuffer)
    func didScan()
}

enum ScanCoordinatorAction {
    case scanned
}

protocol ScanCoordinatorOutput: AnyObject {
    
    var onAction: Closure.Generic<ScanCoordinatorAction>? { get set }
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
    
    weak var view: ScanView?
    
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
        if let predictions = request.results as? [VNRecognizedObjectObservation] {
            let carPredictions = predictions
                .filter { $0.label == Constants.carIdentifier }
                .sorted { (first, second) -> Bool in
                    guard let fConfidence = first.labels.first?.confidence, let sConfidence = second.labels.first?.confidence else {
                        return false
                    }
                    return fConfidence > sConfidence
            }
            
            DispatchQueue.main.async {
                //TODO send endpoint with captured
                //TODO show on UI
            }
        }
    }
}

extension ScanPresenter: ScanControllerOutput {
    
    func viewDidLoad() {
        view?.startCapturing()
    }
    
    func didCaptureFrame(with buffer: CVPixelBuffer) {
        predictUsingVision(pixelBuffer: buffer)
    }
    
    func didScan() {
        onAction?(.scanned)
    }
}
