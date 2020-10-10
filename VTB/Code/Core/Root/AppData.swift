//
//  AppData.swift
//  VTB
//
//  Created by viktor.volkov on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation
import Service

class AppData {
    
    private let service = NetworkService()
    
    static var shared = AppData()
    
    var marketplace: Marketplace?
    
    private init() {
        service.marketplace {
            [unowned self] res in
            
            if case .success(let marketplace) = res {
                self.marketplace = marketplace
            }
        }
    }
}
