//
//  Marketplace.swift
//  VTB
//
//  Created by Иван Федоров on 10.10.2020.
//  Copyright © 2020 IBI-Solutions. All rights reserved.
//

import Foundation

public struct Marketplace: Codable {
    public let list: [ListItem]
}

public struct ListItem: Codable {
    public let country: Country
    public let models: [Model]
    public let currentCarCount: Int
    public let currentModelsTotal: Int
    public let logo: String
    public let title: String
}

public struct Country: Codable {
    public let code: String
    public let title: String
}

public struct Model: Codable {
    public let title: String
    public let titleRus: String
    public let photo: String
    public let minPrice: Int
    public let count: Int
    public let colorsCount: Int
}
