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
import CoreMedia

protocol ScanView: AnyObject {
    
    func startCapturing()
}

final class ScanViewController: UIViewController {
    
    private lazy var scannedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отсканировал", for: .normal)
        button.addTarget(self, action: #selector(scannedAction), for: .touchUpInside)
        return button
    }()
    
    private let videoPreview = UIView()
    
    private lazy var videoCapture: VideoCapture = {
        let capture = VideoCapture()
        capture.delegate = self
        capture.fps = 30
        return capture
    }()

    
    private var request: VNCoreMLRequest?
    private var visionModel: VNCoreMLModel?
    private var isInferencing = false
    
    var output: ScanControllerOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(videoPreview)
        videoPreview.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        output?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        videoCapture.previewLayer?.frame = videoPreview.bounds
    }
    
    @objc private func scannedAction() {
        output?.didScan()
    }
}

extension ScanViewController: ScanView {
    
    func startCapturing() {
        videoCapture.setUp(sessionPreset: .vga640x480) {
            success in
            
            if success {
                if let previewLayer = self.videoCapture.previewLayer {
                    self.videoPreview.layer.addSublayer(previewLayer)
                    self.videoCapture.previewLayer?.frame = self.videoPreview.bounds
                }
                
                self.videoCapture.start()
            }
        }
    }
}


extension ScanViewController: VideoCaptureDelegate {
    
    func videoCapture(_ capture: VideoCapture, didCaptureVideoFrame pixelBuffer: CVPixelBuffer?, timestamp: CMTime) {
        // the captured image from camera is contained on pixelBuffer
        if !self.isInferencing, let pixelBuffer = pixelBuffer {
            output?.didCaptureFrame(with: pixelBuffer)
        }
    }
}
