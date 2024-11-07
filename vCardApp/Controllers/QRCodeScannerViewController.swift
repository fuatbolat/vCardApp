//
//  QRCodeScannerViewController.swift
//  vCardApp
//
//  Created by Fuat Bolat on 26.10.2024.
//

import UIKit
import AVFoundation

class QRCodeScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject, let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            // QR verisini ayrış
            parseQRCodeData(stringValue)
        }

        dismiss(animated: true)
    }

    func parseQRCodeData(_ data: String) {
        let components = data.components(separatedBy: ",")
        var userInfo: [String: String] = [:]

        for component in components {
            let keyValue = component.components(separatedBy: ":")
            if keyValue.count == 2 {
                userInfo[keyValue[0]] = keyValue[1]
            }
        }

        // Dijital kart
        if let name = userInfo["Name"], let number = userInfo["Number"], let email = userInfo["Email"] {
            let digitalCardVC = DigitalCardViewController()
            digitalCardVC.userName = name
            digitalCardVC.userNumber = number
            digitalCardVC.userEmail = email
            present(digitalCardVC, animated: true)
        }
    }
}

