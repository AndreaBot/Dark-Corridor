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
    
    static func spawnAnimation(_ enemy: EnemyStruct, _ view: UIView, _ enemyImage: UIImageView, _ enemyHP: UILabel, _ enemyNameLabel: UILabel, _ stackView: UIStackView) {
        switch enemy.name {
        case AllEnemies.mutantPig.name: CharacterAnimations.slideFromBottom(view, enemyImage, enemyHP, enemyNameLabel, stackView);
        case AllEnemies.possessedSpellbook.name: CharacterAnimations.fadeIn(view, enemyImage, enemyHP, enemyNameLabel, stackView);
        case AllEnemies.hornedBat.name: CharacterAnimations.slideFromTop(view, enemyImage, enemyHP, enemyNameLabel, stackView);
        case AllEnemies.deathsEmissary.name: CharacterAnimations.fadeIn(view, enemyImage, enemyHP, enemyNameLabel, stackView);
        case AllEnemies.creepyLady.name: CharacterAnimations.slideFromRight(view, enemyImage, enemyHP, enemyNameLabel, stackView);
        default:
            print("No animation found")
        }
    }
    
}
