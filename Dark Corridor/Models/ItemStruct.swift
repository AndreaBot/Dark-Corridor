//
//  ItemStruct.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 08/04/2023.
//

import Foundation

struct ItemStruct {
    let name: String
    var qty: Int
    let value: Int
    
    init(n: String, q: Int, v: Int) {
        self.name = n
        self.qty = q
        self.value = v
    }
}

