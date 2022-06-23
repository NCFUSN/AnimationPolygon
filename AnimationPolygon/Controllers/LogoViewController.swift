//
//  LogoViewController.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 09/06/2022.
//

import UIKit

class LogoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        drawLogo()
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

}
