//
//  Character.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 26/03/2023.
//

import UIKit

struct Character {
    
    static var playerName: String?
    static var up = 0
    static var health = 20
    static var currentHealth = 20
    static var damage = 0
    static var attack1 = AttackStruct(name: "Slash", damage: 5)
    static var attack2 = AttackStruct(name: "Charge", damage: 3)
    
    mutating func moveUp()  {
        Character.up += 1
    }
    
    static func attackWorks() -> Bool {
        let chance = Int.random(in: 1...10)
        if chance > 1 {
            return true
        } else {
            return false
        }
    }
    
    static func animateText(_ UILabel: UILabel, _ color: UIColor)  {
        UILabel.textColor = color
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            UILabel.textColor = .white
        }
    }
}

    
    

