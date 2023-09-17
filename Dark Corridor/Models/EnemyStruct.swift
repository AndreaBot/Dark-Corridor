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
    
    init(name: String, totalHealth: Int, currentHealth: Int, attack1: AttackStruct, attack2: AttackStruct, missChance: Int, enemyImage: UIImage, crySoundName: String, souls: Int, timesDefeated: Int) {
        self.name = name
        self.totalHealth = totalHealth
        self.currentHealth = currentHealth
        self.attack1 = attack1
        self.attack2 = attack2
        self.missChance = missChance
        self.enemyImage = enemyImage
        self.crySoundName = crySoundName
        self.souls = souls
        self.timesDefeated = timesDefeated
    }
    
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
