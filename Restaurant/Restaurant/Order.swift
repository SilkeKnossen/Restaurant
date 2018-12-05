//
//  Order.swift
//  Restaurant
//
//  Created by Silke Knossen on 04/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]

    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
