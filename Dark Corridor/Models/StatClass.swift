//
//  StatClass.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 20/09/2023.
//

import Foundation
import RealmSwift

class StatClass: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var value = 0
    @objc dynamic var category = ""
    
    override init() {
        super.init()
    }
    
    init(name: String = "", value: Int = 0, category: String = "") {
        super.init()
        self.name = name
        self.value = value
        self.category = category
    }
}
