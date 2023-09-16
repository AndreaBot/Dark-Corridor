//
//  ItemStruct.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 08/04/2023.
//

import Foundation

struct ItemStruct {
    let text: String
    var qty: Int
    let value: Int
    
    init(t: String, q: Int, v: Int) {
        text = t
        qty = q
        value = v
    }
}

