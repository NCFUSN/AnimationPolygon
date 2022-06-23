//
//  CustomTabViewModel.swift
//  AnimationPolygon
//
//  Created by Nathan Furman on 07/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

class CustomTabViewModel {
    let disposeBag = DisposeBag()
    init() {}
    
    var tabViewBackGroundColour: Observable<UIColor?> {
        return Observable<UIColor?>.just(UIColor(hex: "#f3f3f3ff"))
    }
}
