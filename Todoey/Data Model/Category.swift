//
//  Category.swift
//  Todoey
//
//  Created by Abrar Hoque on 7/2/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    
    @objc dynamic var color : String = ""
    
    let items = List<Item>()
    
    //let array : Array<Int> = [1,2,3]
    
}
