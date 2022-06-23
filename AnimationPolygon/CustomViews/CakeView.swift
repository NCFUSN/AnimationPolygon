//
//  RatingControl.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 12/06/2022.
//

import Foundation
import UIKit

@IBDesignable
class CakeView: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.width / 5, y: rect.height - 10))
        path.addLine(to: CGPoint(x: rect.width / 5 * 4, y: rect.height - 10))
        path.addLine(to: CGPoint(x: rect.width - 10, y: rect.midY))
        path.close()
        UIColor.black.setStroke()
        path.lineWidth = 3
        UIColor.brown.setFill()
        path.fill()
        path.stroke()
        
        let top = UIBezierPath()
        top.move(to: CGPoint(x: rect.width - 10, y: rect.midY))
        var controlPoint1 = CGPoint(x: rect.width, y: rect.height / 5)
        var controlPoint2 = CGPoint(x: rect.width / 3 * 2, y: rect.height / 8)
        top.addCurve(to: CGPoint(x: rect.midX, y: 0), controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        controlPoint1 = CGPoint(x: rect.width / 3, y: rect.height / 8)
        controlPoint2 = CGPoint(x: 0, y: rect.height / 5)
        top.addCurve(to: CGPoint(x: 10, y: rect.midY), controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        top.lineWidth = 3.0
        top.close()
        
        UIColor.systemPink.setFill()
        top.fill()
        top.stroke()
    }
}
