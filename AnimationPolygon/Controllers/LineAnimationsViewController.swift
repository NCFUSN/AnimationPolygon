//
//  LineAnimationsViewController.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 20/06/2022.
//

import UIKit

class LineAnimationsViewController: UIViewController {
    
    @IBOutlet weak private var btn1: UIButton!
    @IBOutlet weak private var btn2: UIButton!
    @IBOutlet weak private var btnCentral: RoundedCloseButton!
    @IBOutlet weak private var btn3: UIButton!
    @IBOutlet weak private var btn4: UIButton!
    
    @IBOutlet weak private var stackView: UIStackView!
    
    var line = UIView()
    var trailingConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    private var latestElement: UIButton?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        btn1.tag = 1
        btn2.tag = 2
        btn3.tag = 3
        btn4.tag = 4
        line.usesAutoLayout = true
        line.backgroundColor = .systemBlue
        line.layer.cornerRadius = 3.0
        line.layer.masksToBounds = true
        self.view.addSubview(line)
        drawInitialLine()
        stackView.bringSubviewToFront(line)
    }
    
    @IBAction func didPressButton(sender: UIButton) {
        switch sender.tag {
        case 1:
            drawTo(element: btn1)
        case 2:
            drawTo(element: btn2)
        case 3:
            drawTo(element: btn3)
        case 4:
            drawTo(element: btn4)
        default:
            return
        }
    }
    
    private func drawInitialLine() {
        line.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        trailingConstraint = NSLayoutConstraint(item: line, attribute: .trailing, relatedBy: .equal, toItem: btn1, attribute: .trailing, multiplier: 1, constant: 0)
        leadingConstraint = NSLayoutConstraint(item: line, attribute: .leading, relatedBy: .equal, toItem: btn1, attribute: .leading, multiplier: 1, constant: 0)
        bottomConstraint = NSLayoutConstraint(item: line, attribute: .bottom, relatedBy: .equal, toItem: btn1, attribute: .top, multiplier: 1, constant: 14)
        
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseIn) { [unowned self] in
            trailingConstraint!.isActive = true
            bottomConstraint?.isActive = true
            leadingConstraint!.isActive = true
            line.layoutIfNeeded()
        }
        latestElement = btn1
    }
    
    private func drawTo(element: UIButton) {
        if isRequestedElementAfterTheLatestElement(element) {
            bindTrailingConstraints(element)
        } else {
            bindLeadingConstraints(element)
        }
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) { [unowned self] in
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.springDumpLine(element: element)
        }
    }
    
    private func springDumpLine(element: UIButton) {
        if isRequestedElementAfterTheLatestElement(element) {
            bindLeadingConstraints(element)
        } else {
            bindTrailingConstraints(element)
        }
        UIView.animate(withDuration: 0.2, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) { [unowned self] in
            self.view.layoutIfNeeded()
            latestElement = element
        }
    }
    
    private func isRequestedElementAfterTheLatestElement(_ element: UIButton) -> Bool {
        if let latestElement = latestElement {
            return element.tag > latestElement.tag
        }
        return false
    }
    
    private func bindTrailingConstraints(_ element: UIButton) {
        trailingConstraint?.isActive = false
        trailingConstraint = line.trailingAnchor.constraint(equalTo: element.trailingAnchor)
        trailingConstraint!.isActive = true
    }
    
    private func bindLeadingConstraints(_ element: UIButton) {
        leadingConstraint?.isActive = false
        leadingConstraint = line.leadingAnchor.constraint(equalTo: element.leadingAnchor)
        leadingConstraint!.isActive = true
    }
}
