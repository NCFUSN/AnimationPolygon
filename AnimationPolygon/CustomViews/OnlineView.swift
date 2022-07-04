//
//  OnlineView.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 04/07/2022.
//

import Foundation
import UIKit

@IBDesignable
class OnlineView: UIView {
    private var pulseLayer = CAShapeLayer()
    @IBInspectable var themeColour: CGColor = UIColor.red.cgColor
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let circularPath = UIBezierPath(arcCenter: .zero, radius: self.frame.size.width/2, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        pulseLayer.path = circularPath.cgPath
        pulseLayer.fillColor = themeColour
        pulseLayer.lineCap = .round
        pulseLayer.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        self.layer.addSublayer(pulseLayer)
        
        let pulse = PulseAnimation(numberOfPulse: Float.infinity, radius: self.frame.size.width, postion: CGPoint(x: pulseLayer.bounds.midX, y: pulseLayer.bounds.midY))
        pulse.animationDuration = 1.2
        pulse.backgroundColor = themeColour
        pulseLayer.insertSublayer(pulse, below: self.layer)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}

fileprivate class PulseAnimation: CALayer {
    var animationGroup = CAAnimationGroup()
    var animationDuration: TimeInterval = 1.5
    var radius: CGFloat = 200
    var numebrOfPulse: Float = Float.infinity
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(numberOfPulse: Float = Float.infinity, radius: CGFloat, postion: CGPoint){
        super.init()
        self.backgroundColor = UIColor.black.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.radius = radius
        self.numebrOfPulse = numberOfPulse
        self.position = postion
        
        self.bounds = CGRect(x: 0, y: 0, width: radius*2, height: radius*2)
        self.cornerRadius = radius
        
        DispatchQueue.global(qos: .default).async {
            self.setupAnimationGroup()
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
           }
        }
    }
    
    func scaleAnimation() -> CABasicAnimation {
        let scaleAnimaton = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimaton.fromValue = NSNumber(value: 0.5)
        scaleAnimaton.toValue = NSNumber(value: 1)
        scaleAnimaton.duration = animationDuration
        return scaleAnimaton
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimiation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimiation.duration = animationDuration
        opacityAnimiation.values = [0.4,0.8,0]
        opacityAnimiation.keyTimes = [0,0.3,1]
        return opacityAnimiation
    }
    
    func setupAnimationGroup() {
        self.animationGroup.duration = animationDuration
        self.animationGroup.repeatCount = numebrOfPulse
        let defaultCurve = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        self.animationGroup.timingFunction = defaultCurve
        self.animationGroup.animations = [scaleAnimation(),createOpacityAnimation()]
    }
}

