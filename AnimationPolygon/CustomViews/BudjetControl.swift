//
//  BudjetControl.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 09/06/2022.
//

import Foundation
import UIKit

@IBDesignable
class BudgetControl: UIView {
  
  let label = UILabel()
  
  // stepper is 0 to 10
  let stepper = UIStepper()
  
  let step: Double = 100  // go up by $100 at a time
  let maxValue:Double = 4
  
  
  var currentValue: Double = 0 {
    didSet {
      label.text = "\(Int(currentValue * step))"
      
      let animation = CABasicAnimation(keyPath: "strokeEnd")
      animation.duration = 1.0
      foregroundLayer.strokeEnd = CGFloat(currentValue/maxValue)
      foregroundLayer.add(animation, forKey: "stroke")
    }
  }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .clear
        setup()
    }
  
  var backgroundLayer = ArcLayer(color: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
  var foregroundLayer = ArcLayer(color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
  
  
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setup()
  }
  
  func setup() {
    buildInterface()
    layer.addSublayer(backgroundLayer)
    layer.addSublayer(foregroundLayer)
    foregroundLayer.strokeEnd = 0
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    backgroundLayer.bounds = bounds
    foregroundLayer.bounds = bounds
  }
  
  
  
  // MARK:- Subviews
  
  @objc func handleStepper(_ stepper: UIStepper) {
    currentValue = stepper.value
  }
  
  func buildInterface() {
    stepper.minimumValue = 0
    stepper.maximumValue = maxValue
    stepper.translatesAutoresizingMaskIntoConstraints = false
    stepper.addTarget(self, action: #selector(handleStepper(_:)), for: .valueChanged)
    stepper.isContinuous = true
    
    addSubview(stepper)
    let stepCenterX = stepper.centerXAnchor.constraint(equalTo: centerXAnchor)
    let stepBottom = stepper.bottomAnchor.constraint(equalTo: bottomAnchor)
    NSLayoutConstraint.activate([stepCenterX, stepBottom])
    
    label.text = "0"
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(label)
    let labelCenterX = label.centerXAnchor.constraint(equalTo: centerXAnchor)
    let labelCenterY = label.centerYAnchor.constraint(equalTo: centerYAnchor)
    NSLayoutConstraint.activate([labelCenterX, labelCenterY])
  }
  
}


class ArcLayer: CAShapeLayer {
  init(color: UIColor) {
    super.init()
    strokeColor = color.cgColor
    lineWidth = 20
    fillColor = nil
    lineCap = .round
  }
  
  override var bounds: CGRect {
    didSet {
      buildLayer()
    }
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(layer: Any) {
    super.init(layer: layer)
  }
  
  func buildLayer() {
    let startAngle = 0.75 * CGFloat.pi
    let endAngle = 0.25 * CGFloat.pi
    let center = CGPoint(x: bounds.midX, y: bounds.midY)
    let radius = bounds.width * 0.35
    let path = UIBezierPath(arcCenter: center,
                            radius: radius,
                            startAngle: startAngle,
                            endAngle: endAngle,
                            clockwise: true)
    self.path = path.cgPath
    position = CGPoint(x: bounds.midX, y: bounds.midY)
  }

}
