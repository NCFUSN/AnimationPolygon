//
//  CustomTab.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 06/06/2022.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

@objc enum CustomBarMember: NSInteger {
    case home
    case podcasts
    case haaretz
    case top
}

@objc protocol CustomTabDelegate: AnyObject {
    func customTab(owner: CustomTab, didPressButton: CustomBarMember)
}

@objc final class CustomTab: UIView {
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnPodcasts: UIButton!
    @IBOutlet weak var btnAlef: UIButton!
    @IBOutlet weak var btnHaaretz: UIButton!
    @IBOutlet weak var btnTop: UIButton!
    @IBOutlet weak var vContentView: UIView!
    @IBOutlet weak var lblObserved: UILabel!
    @IBOutlet weak var lblMyHaaretz: UILabel!
    
    
    public weak var delegate: CustomTabDelegate?
    private var viewModel = CustomTabViewModel()
    private let mockSize = MockSize()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CustomTab", owner: self, options: nil)
        vContentView.fixInView(self)
        subscribe()
        constraint()
        setControls()
    }
    
    private func subscribe() {
        viewModel.tabViewBackGroundColour.subscribe(onNext: { [weak self] colour in
            if let color = colour {
                self?.vContentView.backgroundColor = color
            }
        }).disposed(by: viewModel.disposeBag)
    }
    
    @objc func buttonPressed(sender: UIButton) {
        let coordinates = sender.frame.origin
        if sender == btnAlef {
            delegate?.customTab(owner: self, didPressButton: .home)
        }
        if sender == btnTop {
            delegate?.customTab(owner: self, didPressButton: .top)
        }
        if sender == btnHome {
            delegate?.customTab(owner: self, didPressButton: .home)
        }
        if sender == btnHaaretz {
            delegate?.customTab(owner: self, didPressButton: .haaretz)
        }
        if sender == btnPodcasts {
            delegate?.customTab(owner: self, didPressButton: .podcasts)
        }
    }
    
    private func constraint() {
        btnAlef.translatesAutoresizingMaskIntoConstraints = false
        vContentView.translatesAutoresizingMaskIntoConstraints = false
        //vContentView.heightAnchor.constraint(equalToConstant: mockSize.heightFrom(size: 52.0)).isActive = true
        
        btnAlef.centerXAnchor.constraint(equalTo: vContentView.centerXAnchor).isActive = true
        btnAlef.centerYAnchor.constraint(equalTo: vContentView.centerYAnchor, constant: -30.0).isActive = true
        btnAlef.heightAnchor.constraint(equalToConstant: mockSize.widthFrom(size: 60.0)).isActive = true
        btnAlef.widthAnchor.constraint(equalToConstant: mockSize.widthFrom(size: 60.0)).isActive = true
        btnAlef.layer.cornerRadius = mockSize.widthFrom(size: 60.0) / 2
        btnAlef.clipsToBounds = true
        
        buttons.forEach { btn in
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.heightAnchor.constraint(equalToConstant: mockSize.widthFrom(size: 24.0)).isActive = true
            btn.widthAnchor.constraint(equalToConstant: mockSize.widthFrom(size: 24.0)).isActive = true
            btn.topAnchor.constraint(equalTo: vContentView.topAnchor, constant: mockSize.heightFrom(size: 8.0)).isActive = true
        }
        
        btnTop.trailingAnchor.constraint(equalTo: vContentView.trailingAnchor, constant: -(mockSize.widthFrom(size: 25.0))).isActive = true
        btnHome.leadingAnchor.constraint(equalTo: vContentView.leadingAnchor, constant: (mockSize.widthFrom(size: 25.0))).isActive = true
        btnPodcasts.leadingAnchor.constraint(equalTo: btnHome.leadingAnchor, constant: (mockSize.widthFrom(size: 55.0))).isActive = true
        btnHaaretz.leadingAnchor.constraint(equalTo: btnAlef.trailingAnchor, constant: (mockSize.widthFrom(size: 30.0))).isActive = true
    }
    
    private func setControls() {
        buttons.forEach { btn in
            btn.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        }
        btnAlef.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
    }
    
    private var buttons: [UIButton] {
        return [btnHome, btnTop, btnHaaretz, btnPodcasts]
    }
}
