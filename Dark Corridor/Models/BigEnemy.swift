//
//  File.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 03/04/2023.
//

import Foundation

struct BigEnemy {
        
    var name = ""
    var enemyTxt = "A possessed spellbook attacks you!"
    
    var health = 25
    var currentHealth = 25
    let attacks = ["Spectral Force": 7, "Eerie Spell": 5]
    
    
    mutating func fight() -> Int {
        
        let possibleAttacks = [attacks["Spectral Force"], attacks["Eerie Spell"]]
        let actualDamage = possibleAttacks.randomElement()
        
        return actualDamage!!
    }
    
    func attackMissed() -> Bool {
        let chance = Int.random(in: 1...10)
        if chance <= 3 {
            return true
        } else {
            return false
        }
    }

}

