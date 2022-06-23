//
//  Utils.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 13/06/2022.
//

import Foundation
import UIKit

public struct Utils {
  public static func pathForCircleThatContains(rect: CGRect) -> CGPath {
    let size = rect.smallestContainingSquare
                   .size
                   .rescale(sqrt(2))
    return UIBezierPath(ovalIn: CGRect(centre: rect.centre, size: size)).cgPath
  }
  
  public static func pathForCircleInRect(rect: CGRect, scaled: CGFloat) -> CGPath {
    let size = rect.size.rescale(scaled)
    
    return UIBezierPath(ovalIn: CGRect(centre: rect.centre, size: size)).cgPath
  }
}
