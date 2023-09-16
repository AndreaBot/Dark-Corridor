//
//  AttackStruct.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 14/09/2023.
//

import Foundation

struct AttackStruct {
    let name: String
    var damage: Int
    
    init(n: String, dmg: Int) {
        name = n
        damage = dmg
    }
}
