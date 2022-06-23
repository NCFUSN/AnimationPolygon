//
//  RatingView.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 12/06/2022.
//

import Foundation
import UIKit

@IBDesignable
class RatingView: UIView {
    
    var image: UIImage?
    @IBInspectable var rating: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var cross: UIImage {
        let size = 40
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))
        return renderer.image { context in
            let cgcontext = context.cgContext
            cgcontext.addLines(between: [.zero, CGPoint(x: size, y: size), CGPoint(x: 0, y: size)])
            cgcontext.addLines(between: [CGPoint(x: size, y: 0), CGPoint(x: 0, y: size)])
            cgcontext.setStrokeColor(UIColor.white.cgColor)
            cgcontext.strokePath()
        }
    }
    
    @objc func handleTap(gesture: UITapGestureRecognizer) {
        let width = bounds.width * 0.25
        let location = gesture.location(in: self).x / width
        rating = Int(location) + 1
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:))))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image = Drawing.cupcake(frame: bounds)
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        context?.scaleBy(x: 0.25, y: 0.25)
        for _ in 0..<4 {
            image?.draw(at: .zero)
            context?.translateBy(x: rect.width, y: 0)
        }
        context?.restoreGState()
        context?.saveGState()
        context?.scaleBy(x: 0.25, y: 0.25)
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -rect.height)
        for i in 0..<4 {
            if i >= rating {
                context?.saveGState()
                context?.clip(to: rect, mask: image!.cgImage!)
                UIColor.red.setFill()
                UIRectFill(rect)
                cross.drawAsPattern(in: rect)
                context?.restoreGState()
            }
            context?.translateBy(x: rect.width, y: 0)
        }
        context?.restoreGState()
    }
}

// THis is how to return an image from drawing
/*
func drawCupCake(rect: CGRect) -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: rect.size)
    let image = renderer.image { canvas in
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
    return image
}
 */
