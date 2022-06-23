//
//  ThermometerView.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 09/06/2022.
//

import Foundation
import UIKit

protocol ThermometerViewDelegate: AnyObject {
    func thermometerView(owner: ThermometerView, didChangeValue: CGFloat)
}

@IBDesignable
class ThermometerView: UIView {
    public weak var delegate: ThermometerViewDelegate?
    private let thermoLayer = CAShapeLayer()
    private let levelLayer = CAShapeLayer()
    private let maskLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .clear
        setup()
    }
    
    private var lineWidth: CGFloat {
        return self.bounds.width / 3
    }
    
    @IBInspectable var level: CGFloat = 0.5 {
        didSet {
            if level > 0.5 {
                thermoLayer.fillColor = UIColor.red.cgColor
            } else {
                thermoLayer.fillColor = UIColor.blue.cgColor
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    private func setup() {
        layer.addSublayer(thermoLayer)
        layer.addSublayer(levelLayer)
        let width = bounds.width - lineWidth
        let height = bounds.height - lineWidth / 2
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: height - width, width: width , height: width))
        path.move(to: CGPoint(x: width / 2, y: height - width))
        path.addLine(to: CGPoint(x: width / 2, y: 10))
        thermoLayer.path = path.cgPath
        thermoLayer.strokeColor = UIColor.darkGray.cgColor
        thermoLayer.lineWidth = width / 3
        thermoLayer.position.x = lineWidth / 2
        thermoLayer.lineCap = .round
        
        maskLayer.path = thermoLayer.path
        maskLayer.lineWidth = thermoLayer.lineWidth
        maskLayer.lineCap = thermoLayer.lineCap
        maskLayer.position = thermoLayer.position
        maskLayer.strokeColor = thermoLayer.strokeColor
        maskLayer.lineWidth = thermoLayer.lineWidth - 6
        maskLayer.fillColor = nil
        
        buildLevelLayer()
        levelLayer.mask = maskLayer
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        addGestureRecognizer(pan)
    }
    
    private func buildLevelLayer() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.midX, y: bounds.height))
        path.addLine(to: CGPoint(x: bounds.midX, y: 0))
        levelLayer.strokeColor = UIColor.white.cgColor
        levelLayer.path = path.cgPath
        levelLayer.lineWidth = bounds.width
        levelLayer.strokeEnd = level
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view)
        let percents = translation.y / bounds.height
        level = max(0, min(1, levelLayer.strokeEnd - percents))
        
        // desable animations
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        levelLayer.strokeEnd = level
        delegate?.thermometerView(owner: self, didChangeValue: level)
        CATransaction.commit()
        gesture.setTranslation(.zero, in: gesture.view)
    }
}
