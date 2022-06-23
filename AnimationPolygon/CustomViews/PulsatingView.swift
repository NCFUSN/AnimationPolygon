//
//  PulsatingView.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 23/06/2022.
//

import Foundation
import UIKit

@IBDesignable
class PulsatingView: UIView {
    private var circle = UIBezierPath()
    private let animationGroup = CAAnimationGroup()
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var fillColour: UIColor = .gray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = .green
        circle = UIBezierPath(ovalIn: rect.inset(by: UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)))
        fillColour.setFill()
        circle.fill()
        self.animationGroup.repeatCount = .infinity
        //let defaultCurve = CAMediaTimingFunction(name: .default)
        //self.animationGroup.timingFunction = defaultCurve
        self.animationGroup.animations = [scaleAnimation()]
        
        DispatchQueue.global(qos: .default).async {
            DispatchQueue.main.async {
                self.layer.add(self.animationGroup, forKey: "pulse")
            }
        }
    }
    
    func scaleAnimation() -> CABasicAnimation {
        let scaling = CABasicAnimation(keyPath: "transform.scale")
                scaling.toValue = 1
        scaling.duration = 0.3
//                scaling.autoreverses = true
//                scaling.repeatCount = .infinity
                layer.add(scaling, forKey: nil)
        return scaling
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = 1.5 - (1.5 / 2)
        opacityAnimation.keyTimes = [0, 0.3, 1]
        opacityAnimation.values = [0.4, 0.8, 0]
        return opacityAnimation
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    func setup() {
        
    }
}
