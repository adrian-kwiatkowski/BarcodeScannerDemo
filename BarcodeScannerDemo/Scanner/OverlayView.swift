//
//  OverlayView.swift
//  BarcodeScannerDemo
//
//  Created by Adrian Kwiatkowski on 07/01/2019.
//  Copyright © 2019 Adrian Kwiatkowski. All rights reserved.
//

import UIKit

final class OverlayView: UIView {
    
    public var closeButton: UIButton = UIButton()
    
    convenience init(frame: CGRect, maskRect: CGRect) {
        self.init(frame: frame)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        layer.mask = configureMask(from: maskRect)
        
        setupCloseButton()
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
    
    func setupCloseButton() {
        closeButton.backgroundColor = UIColor.clear
        closeButton.tintColor = UIColor.white
        closeButton.setTitle("x", for: .normal)
        closeButton.titleLabel?.font = UIFont(name: (closeButton.titleLabel?.font.fontName)!, size: 30.0)
        closeButton.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        addSubview(closeButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20.0).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
}
