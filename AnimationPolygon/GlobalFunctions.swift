//
//  GlobalFunctions.swift
//  haaretz
//
//  Created by Nathan Furman on 04/01/2022.
//  Copyright © 2022 Denis Skakun. All rights reserved.
//

import Foundation

@discardableResult
@inlinable
func with<V>(_ value: V, _ mutate: ((_ v: inout V) -> Void)) -> V {
    var mutableValue = value
    mutate(&mutableValue)
    return mutableValue
}

func delay(seconds: TimeInterval, execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
}
