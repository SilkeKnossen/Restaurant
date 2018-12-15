//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by Silke Knossen on 04/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import Foundation

/*
 * Struct to store an array of categories
 */
struct Categories: Codable {
    let categories: [String]
}

/*
 * Struct to store preparation time
 */
struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
