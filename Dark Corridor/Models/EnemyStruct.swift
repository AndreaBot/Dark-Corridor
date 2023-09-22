//
//  EnemyClass.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 14/09/2023.
//

import UIKit

struct EnemyStruct: Equatable {
    static func == (lhs: EnemyStruct, rhs: EnemyStruct) -> Bool {
        return true
    }
    
    var name: String
    var totalHealth: Int
    var currentHealth: Int
    var attack1: AttackStruct
    var attack2: AttackStruct
    var missChance: Int
    var enemyImage: UIImage
    var crySoundName: String
    var souls: Int
    var timesDefeated: Int
    
    func attackMissed(_ enemyChance: Int) -> Bool {
        let chance = Int.random(in: 1...10)
        if chance <= enemyChance {
            return true
        } else {
            return false
        }
    }
    
    func fight() -> Int {
        let possibleAttacks = [attack1.damage, attack2.damage]
        let actualDamage = possibleAttacks.randomElement()
        return actualDamage!
    }
}
