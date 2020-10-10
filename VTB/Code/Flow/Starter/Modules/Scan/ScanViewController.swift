//
//  ScanViewController.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import AVFoundation
import UIKit
import SnapKit
import Vision
import VTBUI

protocol ScanView: AnyObject {
    
    func initializeCapturing()
    func startCapturing()
    func stopCapturing()
    func updateScanViewState(_ state: ScanState)
}

final class ScanViewController: UIViewController {
    
    private let videoPreview = UIView()
    
    private var backgroundView = ScanBackgroundView()
    private var predictionView = PredictionView()
    
    private lazy var videoCapture: VideoCapture = {
        let capture = VideoCapture()
        capture.delegate = self
        capture.fps = 30
        return capture
    }()
    
    var output: ScanControllerOutput?
    
    override var canBecomeFirstResponder: Bool {
        true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(videoPreview)
        view.addSubview(backgroundView)
        backgroundView.addSubview(predictionView)
        videoPreview.snp.makeConstraints { $0.edges.equalToSuperview() }
        backgroundView.snp.makeConstraints { $0.edges.equalToSuperview() }
        predictionView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.4)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(100)
        }
        output?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        videoCapture.previewLayer?.frame = videoPreview.bounds
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else {
            return
        }
        output?.didHandleShake()
    }
}

extension ScanViewController: ScanView {
    
    func initializeCapturing() {
        videoCapture.setUp(sessionPreset: .vga640x480) {
            success in
            
            if success, let previewLayer = self.videoCapture.previewLayer {
                self.videoPreview.layer.addSublayer(previewLayer)
                self.videoCapture.previewLayer?.frame = self.videoPreview.bounds
            }
        }
    }
    
    func startCapturing() {
        videoCapture.start()
    }
    
    func stopCapturing() {
        videoCapture.stop()
    }
    
    func updateScanViewState(_ state: ScanState) {
        let isBackgroundVisible: Bool
        switch state {
        case .capturing:
            self.startCapturing()
            isBackgroundVisible = false
        case .found:
            self.stopCapturing()
            isBackgroundVisible = true
        }
        
        UIView.animate(withDuration: CATransaction.animationDuration()) {
            self.backgroundView.isHidden = !isBackgroundVisible
        }
    }
}


extension ScanViewController: VideoCaptureDelegate {
    
    func videoCapture(_ capture: VideoCapture,
                      didCaptureVideoFrame pixelBuffer: CVPixelBuffer?) {
        if let pixelBuffer = pixelBuffer {
            output?.didCaptureFrame(with: pixelBuffer)
        }
    }
}
