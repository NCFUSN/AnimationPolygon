//
//  ShieldControl.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 13/06/2022.
//

import Foundation
import UIKit

@IBDesignable
class ShieldControl: UIView {
    enum State {
      case off
      case inProgress
      case on
    }
    
    public var state: State = .off {
      didSet {
        switch state {
        case .inProgress:
          showInProgress(true)
        case .on:
          showInProgress(false)
        case .off:
          showInProgress(false)
        }
      }
    }
    
    private let buttonLayer = CALayer()
    private lazy var innerCircle: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = Utils.pathForCircleInRect(rect: buttonLayer.bounds, scaled: CGFloat.innerCircleRatio)
        layer.fillColor = UIColor.lightGray.cgColor
        layer.strokeColor = UIColor.darkGray.cgColor
        layer.lineWidth = 2.0
        
        layer.shadowRadius = 15
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 15, height: 10)
        return layer
    }()
    
    private lazy var outerCircle: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = Utils.pathForCircleInRect(rect: buttonLayer.bounds, scaled: CGFloat.outerCircleRatio)
        layer.fillColor = UIColor.blue.cgColor
        layer.opacity = 0.4
        return layer
    }()
    
    private lazy var inProgressLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.green.cgColor, UIColor(white: 1, alpha: 0).cgColor]
        layer.frame = CGRect(centre: buttonLayer.bounds.centre, size: buttonLayer.bounds.size.rescale(CGFloat.inProgressRatio))
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .clear
        configureLayers()
    }
    
    override func prepareForInterfaceBuilder() {
      super.prepareForInterfaceBuilder()
        configureLayers()
    }
    
    private func configureLayers() {
        //backgroundColor = UIColor.lightGray
        buttonLayer.frame = bounds.largestContainedSquare.offsetBy(dx: 0, dy: 0)
        buttonLayer.addSublayer(outerCircle)
        buttonLayer.addSublayer(innerCircle)
        layer.addSublayer(buttonLayer)
    }
    
    private func showInProgress(_ show: Bool = true) {
        if show {
            inProgressLayer.isHidden = false
        } else {
            inProgressLayer.isHidden = true
        }
    }
}

fileprivate extension CGFloat {
  static var outerCircleRatio: CGFloat = 0.8
  static var innerCircleRatio: CGFloat = 0.55
  static var inProgressRatio: CGFloat = 0.58
}

fileprivate extension Double {
  static var animationDuration: Double = 0.5
  static var inProgressPeriod: Double = 2.0
}
