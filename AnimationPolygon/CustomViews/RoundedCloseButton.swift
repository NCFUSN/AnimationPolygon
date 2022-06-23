//
//  RoundedCloseButton.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 12/06/2022.
//

import Foundation
import UIKit

@IBDesignable
class RoundedCloseButton: UIButton {
    private var circle = UIBezierPath()
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var fillColour: UIColor = .gray
    
    
    override func draw(_ rect: CGRect) {
        circle = UIBezierPath(ovalIn: rect.inset(by: UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)))
        fillColour.setFill()
        circle.fill()
        
        let left = rect.width / 3
        let top = rect.height / 3
        let right = rect.width * 2/3
        let bottom = rect.height * 2/3
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: left, y: top))
        path.addLine(to: CGPoint(x: right, y: bottom))
        path.move(to: CGPoint(x: right, y: top))
        path.addLine(to: CGPoint(x: left, y: bottom))
        path.lineCapStyle = .round
        path.lineWidth = 2.0
        UIColor.white.setStroke()
        path.stroke()
    }
}
