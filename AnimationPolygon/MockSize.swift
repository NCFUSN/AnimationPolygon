//
//  MockSize.swift
//  haaretz
//
//  Created by Nathan Furman on 22/12/2021.
//  Copyright © 2021 Denis Skakun. All rights reserved.
//

import UIKit

struct MockSize {
    let width: CGFloat
    let height: CGFloat
    
    init() {
        width = 320
        height = 568
    }
    
    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
    
    /**
     Calculates the actual height proportioned from screen reflected in Zeplin.
     - Parameter size: height value according to Zeplin mock requirement
     - Returns: `CGFloat` calculated font size.
     */
    func heightFrom(size:  CGFloat) -> CGFloat {
        var size_:CGFloat = 0.0
        let delta = UIScreen.main.bounds.size.height / height
        if delta > 1 {
            size_ = size * delta
        } else {
            return size
        }
        return size_
    }
    
    var fullHeight: CGFloat {
        var size_:CGFloat = 0.0
        let delta = UIScreen.main.bounds.size.height / height
        if delta > 1 {
            size_ = height * delta
        } else {
            return UIScreen.main.bounds.size.height
        }
        return size_
    }
    
    var fullWidth: CGFloat {
        var size_:CGFloat = 0.0
        let delta = UIScreen.main.bounds.size.width / width
        if delta > 1 {
            size_ = width * delta
        } else {
            return UIScreen.main.bounds.size.width
        }
        return size_
    }
    
    /**
     Calculates the actual width proportioned from screen reflected in Zeplin.
     - Parameter size: width value according to Zeplin mock requirement
     - Returns: `CGFloat` calculated font size.
     */
    func widthFrom(size:  CGFloat) -> CGFloat {
        var size_:CGFloat = 0.0
        let delta = UIScreen.main.bounds.size.width / width
        if delta > 1 {
            size_ = size * delta
        } else {
            return size
        }
        return size_
    }
    
    /**
     Calculates the actual width proportioned from screen reflected in Zeplin.
     - Parameter percents: width in percents according to Zeplin mock requirement
     - Returns: `CGFloat` calculated actual width.
     */
    func widthFrom(percents: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.size.width - (percents * (UIScreen.main.bounds.size.width / 100))
    }
    
    /**
     Calculates the actual height proportioned from screen reflected in Zeplin.
     - Parameter percents: height value in percents according to Zeplin mock requirement
     - Returns: `CGFloat` calculated actual height.
     */
    func heightFrom(percents: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.size.height - (percents * (UIScreen.main.bounds.size.height / 100))
    }
    
    /**
     Adapts font size for a screen reflected in Zeplin.
     - Parameter size: Fontsize  according to Zeplin mock requirement
     - Returns: `CGFloat` calculated font size.
     */
    func font(size: CGFloat) -> CGFloat {
        var size_:CGFloat = 0.0
        let delta = UIScreen.main.bounds.size.width / width
        if delta > 1 {
            size_ = size * delta
        } else {
            return size
        }
        return size_
    }
    
    func getStatusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
}
