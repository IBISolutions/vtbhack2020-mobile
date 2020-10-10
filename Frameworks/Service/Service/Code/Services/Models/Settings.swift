//
//  Settings.swift
//  VTB
//
//  Created by Иван Федоров on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation

public struct SpecialConditions: Codable {
    let name: String
    let id: String
    let excludingConditions: [String]
}

public struct Settings: Codable {
    let name: String
    let specialConditions: [SpecialConditions]
}

