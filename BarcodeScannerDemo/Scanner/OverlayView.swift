//
//  OverlayView.swift
//  BarcodeScannerDemo
//
//  Created by Adrian Kwiatkowski on 07/01/2019.
//  Copyright © 2019 Adrian Kwiatkowski. All rights reserved.
//

import UIKit

final class OverlayView: UIView {
    
    private var codeLabel: UILabel = UILabel()
    
    convenience init(frame: CGRect, maskRect: CGRect) {
        self.init(frame: frame)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        layer.mask = configureMask(from: maskRect)
        
        setupCodeLabel(from: frame)
    }
    
    func configureMask(from rect: CGRect) -> CALayer {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = layer.bounds
        let viewPath = UIBezierPath(roundedRect: rect, cornerRadius: 20.0)
        
        let path = UIBezierPath(rect: layer.bounds)
        path.append(viewPath)
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        maskLayer.path = path.cgPath
        
        return maskLayer
    }
    
    func setupCodeLabel(from viewFrame: CGRect) {
        let x = viewFrame.minX + 30
        let y = viewFrame.maxY - (viewFrame.maxY / 5)
        let width = viewFrame.width - 60
        let height = viewFrame.height / 3
        let labelFrame = CGRect(x: x, y: y, width: width, height: height)
        
        codeLabel = UILabel(frame: labelFrame)
        codeLabel.textAlignment = .center
        codeLabel.text = ""
        codeLabel.textColor = UIColor.white
        addSubview(codeLabel)
    }
    
    func setCode(string: String) {
        codeLabel.text = string
    }
}
