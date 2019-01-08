//
//  ScannerView.swift
//  BarcodeScannerDemo
//
//  Created by Adrian Kwiatkowski on 07/01/2019.
//  Copyright © 2019 Adrian Kwiatkowski. All rights reserved.
//

import AVFoundation
import UIKit

protocol ScannerViewDelegate: class {
    func scannerViewDidFoundBarCode(_ scannerView: ScannerView, code: String)
}

final class ScannerView: UIView {
    
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    weak var delegate: ScannerViewDelegate?
    
    convenience init(frame: CGRect, scanArea: CGRect) {
        self.init(frame: frame)
        
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13]
            
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = frame
        previewLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        
        metadataOutput.rectOfInterest = previewLayer.metadataOutputRectConverted(fromLayerRect: scanArea)
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func failed() {
        print("Scanning not supported. Your device does not support scanning a code from an item. Please use a device with a camera.")
        captureSession = nil
    }
    
    func startRunning() {
        if captureSession.isRunning == false {
            captureSession.startRunning()
        }
    }
    
    func stopRunning() {
        if captureSession.isRunning == true {
            captureSession.stopRunning()
        }
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension ScannerView: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
//        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            delegate?.scannerViewDidFoundBarCode(self, code: stringValue)
        }
    }
}
