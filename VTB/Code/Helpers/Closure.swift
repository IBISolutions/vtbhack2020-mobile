//
//  Closure.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation

public enum Closure {

    public typealias Void = (() -> Swift.Void)
    public typealias Boolean = ((Swift.Bool) -> Swift.Void)
    public typealias Int = ((Swift.Int) -> Swift.Void)
    public typealias UInt = ((Swift.UInt) -> Swift.Void)
    public typealias Float = ((Swift.Float) -> Swift.Void)
    public typealias Double = ((Swift.Double) -> Swift.Void)
    public typealias String = ((Swift.String) -> Swift.Void)
    public typealias URL = ((Foundation.URL) -> Swift.Void)
    public typealias Generic<T> = ((T) -> Swift.Void)
}
