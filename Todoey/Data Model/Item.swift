//
//  Item.swift
//  Todoey
//
//  Created by Abrar Hoque on 6/24/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import UIKit


//struct Item {
//    let key: String
//
//    let check: Bool
//}

class Item: Codable {
    var title : String = ""
    var done: Bool = false
}
