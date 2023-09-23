//
//  AllEnemies.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 14/09/2023.
//

import UIKit

struct AllEnemies {
    
    static var mutantPig = EnemyStruct(
        name: "Mutant Pig",
        totalHealth: 15,
        currentHealth: 15,
        attack1: AttackStruct(name: "Bite", damage: 4),
        attack2: AttackStruct(name: "Tackle", damage: 2),
        missChance: 2,
        enemyImage: UIImage(named: "PigBig")!,
        crySoundName: "Pig Cry",
        souls: 1,
        timesDefeated: 0)
    
    static var possessedSpellbook = EnemyStruct(
        name: "Possessed Spellbook",
        totalHealth: 25,
        currentHealth: 25,
        attack1: AttackStruct(name: "Spectral Force", damage: 7),
        attack2: AttackStruct(name: "Eerie Spell", damage: 2),
        missChance: 3,
        enemyImage: UIImage(named: "SpellbookBig")!,
        crySoundName: "Spellbook Cry",
        souls: 2,
        timesDefeated: 0)
    
    static var hornedBat = EnemyStruct(
        name: "Horned Bat",
        totalHealth: 15,
        currentHealth: 15,
        attack1: AttackStruct(name: "Ram", damage: 3),
        attack2: AttackStruct(name: "Screech", damage: 1),
        missChance: 0,
        enemyImage: UIImage(named: "HornedBat")!,
        crySoundName: "HornedBat Cry",
        souls: 1,
        timesDefeated: 0)
}




