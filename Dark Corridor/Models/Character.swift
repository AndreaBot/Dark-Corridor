//
//  Character.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 26/03/2023.
//

import UIKit

struct Character {
    
    var up = 0
    var health = 20
    var currentHealth = 20
    var damage = 0
    let attack1 = AttackStruct(name: "Slash", damage: 1)
    let attack2 = AttackStruct(name: "Charge", damage: 3)
    
    mutating func moveUp()  {
        up += 1
    }
    
    func attackWorks() -> Bool {
        let chance = Int.random(in: 1...10)
        if chance > 1 {
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
}

    
    

