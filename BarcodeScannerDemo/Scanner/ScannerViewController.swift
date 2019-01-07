// source: https://www.hackingwithswift.com/example-code/media/how-to-scan-a-barcode

import AVFoundation
import UIKit

class ScannerViewController: UIViewController {
    
    private var scannerView: ScannerView?
    private var overlayView: OverlayView?
    private var codeLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        let x = view.frame.minX + 30
        let y = view.frame.maxY / 3
        let width = view.frame.width - 60
        let height = view.frame.height / 3
        let scanArea = CGRect(x: x, y: y, width: width, height: height)
        
        scannerView = ScannerView(frame: view.layer.bounds, scanArea: scanArea)
        view.addSubview(scannerView!)
        scannerView?.delegate = self
        
        overlayView = OverlayView(frame: view.layer.bounds, maskRect: scanArea)
        view.addSubview(overlayView!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scannerView?.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        scannerView?.stopRunning()
    }
}

// MARK: - Styling
extension ScannerViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - ScannerViewDelegate
extension ScannerViewController: ScannerViewDelegate {
    func scannerViewDidFoundBarCode(_ scannerView: ScannerView, code: String) {
        overlayView?.setCode(string: code)
    }
}
