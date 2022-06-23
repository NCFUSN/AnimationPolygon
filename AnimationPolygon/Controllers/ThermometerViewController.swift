//
//  ThermometerViewController.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 09/06/2022.
//

import UIKit

class ThermometerViewController: UIViewController, ThermometerViewDelegate {
    
    @IBOutlet weak var thermometerView: ThermometerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        thermometerView.delegate = self
    }
    
    func thermometerView(owner: ThermometerView, didChangeValue: CGFloat) {
        print(didChangeValue)
    }

}
