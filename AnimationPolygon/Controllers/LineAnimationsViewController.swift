//
//  LineAnimationsViewController.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 20/06/2022.
//

import UIKit

class LineAnimationsViewController: UIViewController {
    
    @IBOutlet weak private var btn1: RoundedCloseButton!
    @IBOutlet weak private var btn2: RoundedCloseButton!
    @IBOutlet weak private var btn3: RoundedCloseButton!
    @IBOutlet weak private var btn4: RoundedCloseButton!
    @IBOutlet weak private var stv: UIStackView!
    private var shapeLayer: CAShapeLayer?
    var fromPoint: CGPoint = .zero
    var untilPoint: CGPoint = .zero
    var previousElement: CGPoint = .zero
    

    override func viewDidLoad() {
        super.viewDidLoad()
        btn1.tag = 1
        btn2.tag = 2
        btn3.tag = 3
        btn4.tag = 4
        /*
        let radarLayer = CAShapeLayer()
        radarLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height);
            radarLayer.path = UIBezierPath(rect: radarLayer.frame).cgPath
            radarLayer.fillColor = UIColor.green.cgColor
        radarLayer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
            radarLayer.cornerRadius = radarLayer.frame.size.width/2
            radarLayer.masksToBounds = true
            radarLayer.opacity = 0
        self.view.layer.addSublayer(radarLayer)
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
            pulseAnimation.repeatCount = Float.infinity
            pulseAnimation.fromValue = 0
            pulseAnimation.toValue = 0.4
            pulseAnimation.isRemovedOnCompletion = false

            let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
            fadeOutAnimation.duration = 2.5
        fadeOutAnimation.fromValue = 0
        fadeOutAnimation.toValue = 0.1
            fadeOutAnimation.repeatCount = Float.infinity

            let animationGroup = CAAnimationGroup()
            animationGroup.duration = 2.5
            animationGroup.animations = [pulseAnimation, fadeOutAnimation]
            animationGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            animationGroup.repeatCount = .greatestFiniteMagnitude
            animationGroup.fillMode = CAMediaTimingFillMode.forwards
            animationGroup.isRemovedOnCompletion = false
        radarLayer.add(animationGroup, forKey: "pulse")
        
        */
        /*
        let radarLayer = CAShapeLayer()
        radarLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height);
            radarLayer.path = UIBezierPath(rect: radarLayer.frame).cgPath
            radarLayer.fillColor = UIColor.orange.cgColor
        radarLayer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
            radarLayer.cornerRadius = radarLayer.frame.size.width/2
            radarLayer.masksToBounds = true
            radarLayer.opacity = 0
        self.view.layer.addSublayer(radarLayer)

            let circleLayer = CAShapeLayer()
            circleLayer.frame = CGRect(x: 0, y: 0, width: 16, height: 16);
            circleLayer.path = UIBezierPath(rect: circleLayer.frame).cgPath
            circleLayer.fillColor = UIColor.orange.cgColor
        circleLayer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
            circleLayer.cornerRadius = circleLayer.frame.size.width/2
            circleLayer.masksToBounds = true
        self.view.layer.addSublayer(circleLayer)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.fromValue = 0
            scaleAnimation.toValue = 1

            let alphaAnimation = CABasicAnimation(keyPath: "opacity")
            alphaAnimation.fromValue = 1
            alphaAnimation.toValue = 0

            let animations = CAAnimationGroup()
            animations.duration = 0.8
            animations.repeatCount = Float.infinity
        animations.timingFunction = CAMediaTimingFunction(name: .easeOut)
            animations.animations = [scaleAnimation, alphaAnimation]

        radarLayer.add(animations, forKey: "animations")
        */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //drawDottedHolder()
        //didPressButton(sender: btn1)
    }
    
    var btn1UpperSpace: CGRect {
        let stvFrame = stv.arrangedSubviews[0].frame
        let rect = CGRect(x: stvFrame.midX, y: stv.frame.midY - stvFrame.height, width: btn4.bounds.width, height: stv.frame.height / 5)
        return rect
    }
    
    var btn2UpperSpace: CGRect {
        let stvFrame = stv.arrangedSubviews[1].frame
        let rect = CGRect(x: stvFrame.midX, y: stv.frame.midY - stvFrame.height, width: btn4.bounds.width, height: stv.frame.height / 5)
        return rect
    }
    
    var btn3UpperSpace: CGRect {
        let stvFrame = stv.arrangedSubviews[2].frame
        let rect = CGRect(x: stvFrame.midX, y: stv.frame.midY - stvFrame.height, width: btn4.bounds.width, height: stv.frame.height / 5)
        return rect
    }
    var btn4UpperSpace: CGRect {
        let stvFrame = stv.arrangedSubviews[3].frame
        let rect = CGRect(x: stvFrame.midX, y: stv.frame.midY - stvFrame.height, width: btn4.bounds.width, height: stv.frame.height / 5)
        return rect
    }
    
    @IBAction func didPressButton(sender: RoundedCloseButton) {
        
        var rect: CGRect = .zero
        switch sender.tag {
        case 1: rect = btn1UpperSpace
            break
        case 2: rect = btn2UpperSpace
            break
        case 3: rect = btn3UpperSpace
            break
        case 4: rect = btn4UpperSpace
            break
        default: rect = .zero
        }
        fromPoint = CGPoint(x: rect.centre.x - btn3.bounds.width/2, y: rect.centre.y)
        untilPoint = CGPoint(x: rect.centre.x + btn3.bounds.width/2, y: rect.centre.y)
        self.drawLine(fromPoint: fromPoint, untilPoint: untilPoint)
        previousElement = untilPoint
    }
    
    private func drawLine(fromPoint: CGPoint, untilPoint: CGPoint) {
        print("COORD:: FROM: \(fromPoint) UNTIL: \(untilPoint)")
        self.shapeLayer?.removeFromSuperlayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        path.addLine(to: CGPoint(x: untilPoint.x, y: untilPoint.y))
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 2 * 2.0
        shapeLayer.lineCap = .round
        shapeLayer.path = path.cgPath
        //shapeLayer.strokeStart = 1
        //shapeLayer.strokeEnd = 0.5
        
        
        self.view.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 0.2
        animation.fillMode = .both
        animation.autoreverses = false
        animation.isCumulative = true
        shapeLayer.add(animation, forKey: "Animation")
        self.shapeLayer = shapeLayer
        
        /*
        self.shapeLayer?.removeFromSuperlayer()
        self.shapeLayer = CAShapeLayer()
        self.view.layer.addSublayer(shapeLayer!)
        let path = UIBezierPath()
        //path.move(to: CGPoint(x: 10, y: 50))
        //path.addLine(to: CGPoint(x: 200, y: 50))
        path.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        path.addLine(to: CGPoint(x: untilPoint.x, y: untilPoint.y))
        shapeLayer!.strokeColor = UIColor.blue.cgColor
        shapeLayer!.lineCap = .round
        shapeLayer!.lineWidth = 2 * 2.0
        shapeLayer!.path = path.cgPath
        //shapeLayer!.strokeStart = 0.4
        
        
        let startAnimation = CABasicAnimation(keyPath: "strokeStart")
        //startAnimation.fromValue = 0.5
        startAnimation.toValue = 0
        
        let animation = CAAnimationGroup()
        animation.animations = [startAnimation]
        animation.duration = 0.3
        shapeLayer!.add(animation, forKey: "Animation")
        lastFromPoint = untilPoint
         */
    
        /*
         let startAnimation = CABasicAnimation(keyPath: "strokeStart")
         startAnimation.fromValue = 0
         startAnimation.toValue = 0.8

         let endAnimation = CABasicAnimation(keyPath: "strokeEnd")
         endAnimation.fromValue = 0.2
         endAnimation.toValue = 1.0

         let animation = CAAnimationGroup()
         animation.animations = [startAnimation, endAnimation]
         animation.duration = 2
         shapeLayer.add(animation, forKey: "MyAnimation")
         */
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    fileprivate func drawDottedHolder() {
        let layer = CAShapeLayer()
        let bounds = CGRect(x: 70, y: 50, width: 250, height: 250)
        layer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 20, height: 20)).cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.lineDashPattern = [8, 6]
        layer.fillColor = nil
        view.layer.addSublayer(layer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.autoreverses = false
        animation.repeatCount = .nan
        layer.add(animation, forKey: "line")
    }
    
    
    
    private func animateButtonPressEvent(tag: Int) {
        var btn: RoundedCloseButton
        switch tag {
        case 1: btn = btn1
            break
        case 2: btn = btn2
            break
        case 3: btn = btn3
            break
        case 4: btn = btn4
            break
        default: break
        }
    }
}


/*
 
 self.shapeLayer?.removeFromSuperlayer()
 self.shapeLayer = CAShapeLayer()
 let path = UIBezierPath()
 path.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
 path.addLine(to: CGPoint(x: untilPoint.x, y: untilPoint.y))
 shapeLayer!.strokeColor = UIColor.blue.cgColor
 shapeLayer!.lineCap = .round
 shapeLayer!.lineWidth = 2 * 2.0
 shapeLayer!.path = path.cgPath
 self.view.layer.addSublayer(shapeLayer!)
 let animation = CABasicAnimation(keyPath: "strokeStart")
 animation.fromValue = 0
 animation.duration = 1
 animation.isAdditive = true
 shapeLayer!.add(animation, forKey: "strokeStart")
 */

/*
 
 let path = UIBezierPath()
 path.move(to: CGPoint(x: 10, y: 130))
 path.addCurve(to: CGPoint(x: 210, y: 200), controlPoint1: CGPoint(x: 50, y: -100), controlPoint2: CGPoint(x: 100, y: 350))
 
 let shapeLayer = CAShapeLayer()
 shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
 shapeLayer.strokeColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1).cgColor
 shapeLayer.lineWidth = 5
 shapeLayer.path = path.cgPath
 shapeLayer.strokeStart = 0.8

 let startAnimation = CABasicAnimation(keyPath: "strokeStart")
 startAnimation.fromValue = 0
 startAnimation.toValue = 0.8

 let endAnimation = CABasicAnimation(keyPath: "strokeEnd")
 endAnimation.fromValue = 0.2
 endAnimation.toValue = 1.0

 let animation = CAAnimationGroup()
 animation.animations = [startAnimation, endAnimation]
 animation.duration = 2
 shapeLayer.add(animation, forKey: "MyAnimation")
 
 */
