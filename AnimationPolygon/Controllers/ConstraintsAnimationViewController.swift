//
//  ConstraintsAnimationViewController.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 19/06/2022.
//

import UIKit

class ConstraintsAnimationViewController: UIViewController {
    
    @IBOutlet weak private var theview: UIView!
    @IBOutlet weak private var trailingConstraint: NSLayoutConstraint!
    private var rotationAngle = 0.0
    @IBOutlet weak private var btn: RoundedCloseButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        btn.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
      let translation = gesture.translation(in: view)
      guard let gestureView = gesture.view else {
        return
      }

      gestureView.center = CGPoint(
        x: gestureView.center.x + translation.x,
        y: gestureView.center.y + translation.y
      )
      gesture.setTranslation(.zero, in: view)
    }
    
    @IBAction func moveRoundButton() {
        UIView.animate(withDuration: 1 / 4, delay: 0, options: .curveEaseIn, animations: { [unowned self] in
            btn.center = CGPoint(
                x: btn.center.x + 20, y: btn.center.y + 10
            )
            if btn.center.x + btn.bounds.width / 2 >= view.bounds.maxX {
                btn.center = CGPoint(
                    x: self.view.center.x, y: self.view.center.y
                )
            }
        })
    }
    
    @IBAction func animate() {
        UIView.animate(withDuration: 1 / 3, delay: 0, options: .curveEaseIn, animations: { [unowned self] in
            rotationAngle += .pi / 4
            self.theview.transform = .init(rotationAngle: rotationAngle)
        })
    }
    
    @IBAction func dropPants() {
        let imageView = UIImageView(image: UIImage(named: "summericons_100px_03"))
        imageView.backgroundColor = .init(white: 0, alpha: 0.5)
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        let bottomConstraint = imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: imageView.frame.height)
        let widthConstraint = imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3, constant: -50.0)
        NSLayoutConstraint.activate([
            bottomConstraint,
            widthConstraint,
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
        
        view.layoutIfNeeded()
        
        // pants show up
        UIView.animate(withDuration: 0.8) {
            bottomConstraint.constant = imageView.frame.height * -5
            widthConstraint.constant = 0.0
            self.view.layoutIfNeeded()
        }
        
        // pants show off
        UIView.animate(withDuration: 2/3, delay: 2, animations: {
            bottomConstraint.constant = imageView.frame.height
            widthConstraint.constant = -50
            self.view.layoutIfNeeded()
        }, completion: { _ in
            imageView.removeFromSuperview()
        })
    }
    
    @IBAction func showSpringNimation() {
        let imageView = UIImageView(image: UIImage(named: "summericons_100px_06"))
        imageView.backgroundColor = .init(white: 0, alpha: 0)
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        let containerView = UIView(frame: imageView.frame)
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: containerView.bounds.height / 2)
        let widthConstraint = containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3, constant: -50.0)
        NSLayoutConstraint.activate([
            bottomConstraint,
            widthConstraint,
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: containerView.heightAnchor),
            imageView.heightAnchor.constraint(equalTo: containerView.widthAnchor)
        ])
        
        view.layoutIfNeeded()
        
        // ball show up
        UIView.animate(withDuration: 1/3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: []) {
            bottomConstraint.constant = imageView.frame.height * -5
            widthConstraint.constant = 0.0
            self.view.layoutIfNeeded()
        }
        
        delay(seconds: 1) {
            UIView.transition(with: containerView,
                              duration: 1,
                              options: .transitionCrossDissolve,
                              animations: imageView.removeFromSuperview,
                              completion: { _ in containerView.removeFromSuperview()})
        }
    }
}
