//
//  LineViewController.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 18/07/2022.
//

import Foundation
import UIKit

class LineViewController: UIViewController {
    @IBOutlet private var btn: RoundedCloseButton!
    @IBOutlet private var btn2: RoundedCloseButton!
    var line = UIView()
    var trailingConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn.tag = 0
        btn2.tag = 1
        line.usesAutoLayout = true
        line.backgroundColor = .red
        line.layer.cornerRadius = 3.0
        line.layer.masksToBounds = true
        self.view.addSubview(line)
        drawInitialLine()
    }
    
    @IBAction private func btnFired(sender: RoundedCloseButton) {
        switch sender.tag {
        case 0:
            drawTo(element: btn)
        case 1:
            drawTo(element: btn2)
        default:
            return
        }
    }
    
    private func drawInitialLine() {
        line.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        trailingConstraint = NSLayoutConstraint(item: line, attribute: .trailing, relatedBy: .equal, toItem: btn, attribute: .trailing, multiplier: 1, constant: 0)
        leadingConstraint = NSLayoutConstraint(item: line, attribute: .leading, relatedBy: .equal, toItem: btn, attribute: .leading, multiplier: 1, constant: 0)
        bottomConstraint = NSLayoutConstraint(item: line, attribute: .bottom, relatedBy: .equal, toItem: btn, attribute: .top, multiplier: 1, constant: -6)
        
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseIn) { [unowned self] in
            trailingConstraint!.isActive = true
            bottomConstraint?.isActive = true
            leadingConstraint!.isActive = true
            line.layoutIfNeeded()
        }
    }
    
    
    
    private func drawTo(element: RoundedCloseButton) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) { [unowned self] in
            trailingConstraint?.isActive = false
            trailingConstraint = line.trailingAnchor.constraint(equalTo: element.trailingAnchor)
            trailingConstraint!.isActive = true
            self.view.layoutIfNeeded()
        } completion: { res in
            self.springDumpLine(element: element)
        }
    }
    
    private func springDumpLine(element: RoundedCloseButton) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) { [unowned self] in
            leadingConstraint?.isActive = false
            leadingConstraint = line.leadingAnchor.constraint(equalTo: element.leadingAnchor)
            leadingConstraint?.isActive = true
            self.view.layoutIfNeeded()
        }
    }
}
