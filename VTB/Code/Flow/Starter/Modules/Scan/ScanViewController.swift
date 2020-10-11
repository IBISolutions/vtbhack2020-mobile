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
import Resources

protocol ScanView: AnyObject {
    
    func initializeCapturing()
    func startCapturing()
    func stopCapturing()
    func updateCarInfo(name: String, offers: String)
    func updateScanViewState(_ state: ScanState)
}

final class ScanViewController: UIViewController {
    
    private let videoPreview = UIView()
    
    private lazy var backgroundView: ScanBackgroundView = {
        let view = ScanBackgroundView()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapBackgroundAction))
        view.addGestureRecognizer(tapGestureRecognizer)
        return view
    }()
    private var predictionView = PredictionView()
    
    private lazy var videoCapture: VideoCapture = {
        let capture = VideoCapture()
        capture.delegate = self
        capture.fps = 30
        return capture
    }()
    
    private lazy var closeButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setImage(R.image.main.close(), for: .normal)
        button.tintColor = .white
        button.onTap = {
            [weak self] in
            
            self?.output?.didTapOnClose()
        }
        return button
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
        predictionView.isHidden = true
        backgroundView.isHidden = true
        videoPreview.snp.makeConstraints { $0.edges.equalToSuperview() }
        backgroundView.snp.makeConstraints { $0.edges.equalToSuperview() }
        predictionView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.4)
        }
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(16)
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
    
    @objc private func tapBackgroundAction() {
        output?.didTapOnBackground()
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
    
    func updateCarInfo(name: String, offers: String) {
        predictionView.configure(header: name, offers: offers, showsLoader: false)
    }
    
    func updateScanViewState(_ state: ScanState) {
        let isBackgroundVisible: Bool
        let alpha: CGFloat
        switch state {
        case .capturing:
            startCapturing()
            isBackgroundVisible = false
            alpha = .zero
        case .found:
            stopCapturing()
            isBackgroundVisible = true
            alpha = 1
        }
        
        predictionView.configure(showsLoader: isBackgroundVisible)
        
        UIView.animate(withDuration: CATransaction.animationDuration()) {
            self.backgroundView.alpha = alpha
        } completion: {
            _ in
            
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
