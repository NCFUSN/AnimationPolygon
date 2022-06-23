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
    var lastFromPoint: CGPoint = .zero
    var lastUntilPoint: CGPoint = .zero
    

    override func viewDidLoad() {
        super.viewDidLoad()
        btn1.tag = 1
        btn2.tag = 2
        btn3.tag = 3
        btn4.tag = 4
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
        if lastFromPoint == .zero {
            lastFromPoint = CGPoint(x: rect.centre.x - 25.0, y: rect.centre.y)
        } else if sender.tag == 1 {
            lastFromPoint = CGPoint(x: btn1UpperSpace.centre.x - 25.0, y: btn1UpperSpace.centre.y)
            lastUntilPoint = CGPoint(x: btn1UpperSpace.centre.x + 25.0, y: btn1UpperSpace.centre.y)
            drawLine(fromPoint: lastFromPoint, untilPoint: lastUntilPoint)
            return
        }
        
        lastUntilPoint = CGPoint(x: rect.centre.x + 25.0, y: rect.centre.y)
        self.drawLine(fromPoint: lastFromPoint, untilPoint: lastUntilPoint)
    }
    
    private func drawLine(fromPoint: CGPoint, untilPoint: CGPoint) {
        //self.shapeLayer?.removeFromSuperlayer()
        if self.shapeLayer == nil {
            self.shapeLayer?.removeFromSuperlayer()
            self.shapeLayer = CAShapeLayer()
            self.view.layer.addSublayer(shapeLayer!)
        }
        let path = UIBezierPath()
        path.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        path.addLine(to: CGPoint(x: untilPoint.x, y: untilPoint.y))
        shapeLayer!.strokeColor = UIColor.blue.cgColor
        shapeLayer!.lineCap = .round
        shapeLayer!.lineWidth = 2 * 2.0
        shapeLayer!.path = path.cgPath
        
        
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.fromValue = 0
        animation.duration = 1
        //animation.isAdditive = true
        shapeLayer!.add(animation, forKey: "strokeStart")
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
