//
//  PulsatingDotAnimatedView.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 23/06/2022.
//

import Foundation
import UIKit

final class PulsatingDotAnimatedLayer: CALayer {
    var animationDuration: TimeInterval = 1.5
    private var radius: CGFloat = 200
    private var numberOfPulses: Float = .infinity
    private let animationGroup = CAAnimationGroup()
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(numberOfPulses: Float = .infinity, radius: CGFloat, position: CGPoint) {
        super.init()
        self.backgroundColor = UIColor.clear.cgColor
        self.contentsScale = UIScreen.main.scale
        self.numberOfPulses = numberOfPulses
        self.opacity = 0
        self.radius = radius
        self.position = position
        self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        self.cornerRadius = radius
        DispatchQueue.global(qos: .default).async {
            self.setupAnimationGroup()
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
            }
        }
    }
    
    func scaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: 0)
        scaleAnimation.fromValue = NSNumber(value: 1)
        scaleAnimation.duration = animationDuration
        return scaleAnimation
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = animationDuration //- (animationDuration / 2)
        opacityAnimation.keyTimes = [0.3, 0.3, 1]
        opacityAnimation.values = [0.4, 0.8, 0]
        return opacityAnimation
    }
    
    func setupAnimationGroup() {
        self.animationGroup.duration = animationDuration
        self.animationGroup.repeatCount = numberOfPulses
        let defaultCurve = CAMediaTimingFunction(name: .default)
        self.animationGroup.timingFunction = defaultCurve
        self.animationGroup.animations = [scaleAnimation(), createOpacityAnimation()]
    }
}
