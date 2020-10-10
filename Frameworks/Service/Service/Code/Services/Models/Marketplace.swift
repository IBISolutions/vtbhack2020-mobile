//
//  Marketplace.swift
//  VTB
//
//  Created by Иван Федоров on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation

public struct Marketplace: Codable {
    let list: [ListItem]
}

public struct ListItem: Codable {
    let country: Country
    let models: [Model]
    let currentCarCount: Int
    let currentModelsTotal: Int
    let logo: String
    let title: String
}

public struct Country: Codable {
    let code: String
    let title: String
}

public struct Model: Codable {
    let title: String
    let titleRus: String
    let photo: String
    let minPrice: Int
    let count: Int
    let colorsCount: Int
}

