//
//  ViewController.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 02/06/2022.
//

import UIKit
import MotionMachine

class ViewController: UIViewController, CustomTabDelegate {
    
    weak var shapeLayer: CAShapeLayer?
    
    @IBOutlet weak var customTab: CustomTab!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnRounded: RoundedCloseButton!
    @IBOutlet weak var pulsatingView: PulsatingButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func startAnimating(fromPoint: CGPoint, untilPoint: CGPoint) {
        self.shapeLayer?.removeFromSuperlayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: fromPoint.x + 25.0, y: fromPoint.y))
        path.addLine(to: CGPoint(x: untilPoint.x + 25.0, y: untilPoint.y))
        

            // create shape layer for that path
        
        view.clipsToBounds = true
        view.layer.cornerRadius = 10.0
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect:view.bounds, cornerRadius:10.0).cgPath
        //shapeLayer.frame = view.bounds
        //shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        shapeLayer.lineWidth = 10 * 2.0 // doubled since half will be clipped
        //shapeLayer.lineDashPattern = [15.0]
        view.layer.addSublayer(shapeLayer)

//            let shapeLayer = CAShapeLayer()
//            shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
//            shapeLayer.strokeColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1).cgColor
//            shapeLayer.lineWidth = 10
            shapeLayer.path = path.cgPath

            // animate it

            view.layer.addSublayer(shapeLayer)
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 0.3
            shapeLayer.add(animation, forKey: "LineMoveAnimation")

            // save shape layer

            self.shapeLayer = shapeLayer

    }
    
    func customTab(owner: CustomTab, didPressButton: CustomBarMember) {
        var button = ""
        var colour: UIColor
        switch didPressButton {
        case .home:
            colour = .orange
            button = "Alef"
        case .podcasts:
            colour = .green
            button = "podcasts"
        case .haaretz:
            colour = .blue
            button = "my haaretz"
        case .top:
            colour = .black
            button = "10 observed"
        }
        lblMessage.text = "Pressed: \(button) button"
        self.view.backgroundColor = colour
    }
    
    func drawOval() {
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 10, y: 10, width: 100, height: 100))
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.yellow.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2.0
        view.layer.addSublayer(shapeLayer)
    }
    
    func drawLogo() {
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 5, y: 5))
        path.addLine(to: CGPoint(x: 5, y: 130))
        path.addLine(to: CGPoint(x: 127, y: 130))
        
        path.addLine(to: CGPoint(x: 127, y: 28))
        path.addLine(to: CGPoint(x: 86, y: 96))
        path.addLine(to: CGPoint(x: 68, y: 70))
        path.addLine(to: CGPoint(x: 48, y: 96))
        path.addLine(to: CGPoint(x: 32, y: 59))
        
        path.addQuadCurve(to: CGPoint(x: 5, y: 5), controlPoint: CGPoint(x: 95, y: 5))
        
        path.close()
        shapeLayer.path = path.cgPath
        shapeLayer.lineJoin = .round
        shapeLayer.fillColor = UIColor.yellow.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.bounds = path.bounds
        shapeLayer.position.x = self.view.bounds.midX
        shapeLayer.position.y = self.view.bounds.midY
        
        let layer2 = CALayer()
        layer2.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        layer2.position = shapeLayer.position
        layer2.backgroundColor = UIColor.blue.cgColor
        shapeLayer.zPosition = 10
        self.view.layer.addSublayer(layer2)
        
        view.layer.addSublayer(shapeLayer)
    }
    
    @IBAction func roundedButtonDidPress(sender: RoundedCloseButton) {
        let pulseAnimation = PulsatingDotAnimatedLayer(numberOfPulses: 1.0, radius: sender.bounds.height * 1.2, position: sender.center)
        pulseAnimation.animationDuration = 2.0
        pulseAnimation.backgroundColor = UIColor.red.cgColor
        self.view.layer.insertSublayer(pulseAnimation, below: self.view.layer)
    }
}

