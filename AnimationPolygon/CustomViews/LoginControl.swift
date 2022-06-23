//
//  LoginControl.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 12/06/2022.
//

import Foundation
import UIKit

import UIKit

@IBDesignable
class LoginView: UIView {
  
  let gradientLayer = CAGradientLayer()
  
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
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setup()
  }
  
  func setup() {
    layer.addSublayer(gradientLayer)
    setupControls()
    
    gradientLayer.shadowOffset = CGSize(width: 5, height: 5)
    gradientLayer.shadowOpacity = 0.5
    gradientLayer.shadowRadius = 5
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    gradientLayer.bounds = bounds
    
    let dark = #colorLiteral(red: 0.2651053071, green: 0.1684348583, blue: 0.7054899335, alpha: 1).cgColor
    let light = #colorLiteral(red: 0.7299370766, green: 0.4124585092, blue: 0.8224056959, alpha: 1).cgColor
    gradientLayer.colors = [dark, light]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    
    gradientLayer.anchorPoint = .zero
    
    name.layer.cornerRadius = name.bounds.midY
    password.layer.cornerRadius = password.bounds.midY
    button.layer.cornerRadius = button.bounds.midY
    
    
  }

  // M Subviews
  
  final class TextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
      return makeInsetRect(bounds: bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
      return makeInsetRect(bounds: bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return makeInsetRect(bounds: bounds)
    }
    
    private func makeInsetRect(bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: 20, dy: 0)
    }
    
  }
  
  let name = TextField()
  let password = TextField()
  let button = UIButton()
  
  func setupControls() {
    addSubview(name)
    addSubview(password)
    addSubview(button)
    name.backgroundColor = .white
    name.placeholder = "name"
    password.backgroundColor = .white
    password.placeholder = "password"
    password.isSecureTextEntry = true
    button.setTitle("Login", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = #colorLiteral(red: 1, green: 0.8000000119, blue: 0, alpha: 1)
    
    name.translatesAutoresizingMaskIntoConstraints = false
    var centerX = name.centerXAnchor.constraint(equalTo: centerXAnchor)
      var top = name.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 7)
    var width = name.widthAnchor.constraint(equalToConstant: bounds.width/1.4)
    var height = name.heightAnchor.constraint(equalToConstant: 50)
    
    NSLayoutConstraint.activate([centerX, top, width, height])
    
    password.translatesAutoresizingMaskIntoConstraints = false
    centerX = password.centerXAnchor.constraint(equalTo: centerXAnchor)
      top = password.topAnchor.constraint(equalToSystemSpacingBelow: name.topAnchor, multiplier: 8)
    width = password.widthAnchor.constraint(equalToConstant: bounds.width / 1.4)
    height = password.heightAnchor.constraint(equalToConstant: 50)
    
    NSLayoutConstraint.activate([centerX, top, width, height])
    
    button.translatesAutoresizingMaskIntoConstraints = false
    centerX = button.centerXAnchor.constraint(equalTo: centerXAnchor)
      top = button.topAnchor.constraint(equalToSystemSpacingBelow: password.topAnchor, multiplier: 10)
    width = button.widthAnchor.constraint(equalToConstant: bounds.width / 3)
    height = button.heightAnchor.constraint(equalToConstant: 44)
    
    NSLayoutConstraint.activate([centerX, top, width, height])
    
  }
}
