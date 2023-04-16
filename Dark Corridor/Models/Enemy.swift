//
//  Game Brain.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 26/03/2023.
//

import UIKit

struct Enemy {
    
    var allEnemies = ["pig", "book"]
    var name = ""
    var enemyTxt = "A mutant pig attacks you!"
        
    var health = 15
    var currentHealth = 15
    var attacks = ["Bite": 4, "Tackle": 2]

    
    mutating func Fight() -> Int {
        
        let possibleAttacks = [attacks["Bite"], attacks["Tackle"]]
        let actualDamage = possibleAttacks.randomElement()
        
            return actualDamage!!
        }

    func attackMissed() -> Bool {
        let chance = Int.random(in: 1...10)
        if chance <= 2 {
            return true
        } else {
            return false
        }
    }

    func animateText(_ UILabel: UILabel, _ color: UIColor)  {
        UILabel.textColor = color
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            UILabel.textColor = .white
        }
    }
    
    
   func enemyFound() -> String {
        let enemyFound = allEnemies.randomElement()
        return enemyFound!
    }
    

}



