//
//  Settings.swift
//  VTB
//
//  Created by Иван Федоров on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation

public struct SpecialConditions: Codable {
    
    public let name: String
    public let id: String
    public let excludingConditions: [String]
}

public struct Settings: Codable {
    
    public let name: String
    public let specialConditions: [SpecialConditions]
}

