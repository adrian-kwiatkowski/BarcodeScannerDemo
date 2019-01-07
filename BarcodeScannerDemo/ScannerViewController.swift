// source: https://www.hackingwithswift.com/example-code/media/how-to-scan-a-barcode

import AVFoundation
import UIKit

class ScannerViewController: UIViewController {
    
    private var scannerView: ScannerView?
    private var overlayView: UIView = UIView()
    
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
        
        let testView = UIView(frame: scanArea)
        testView.layer.borderWidth = 1
        testView.layer.borderColor = UIColor.white.cgColor
        view.addSubview(testView)
        
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
