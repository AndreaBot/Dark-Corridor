//
//  AllEnemies.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 14/09/2023.
//

import UIKit

struct AllEnemies {
    
    static var pig = EnemyStruct(
        name: "Mutant Pig",
        totalHealth: 15,
        currentHealth: 15,
        attack1: AttackStruct(n: "Bite", dmg: 4),
        attack2: AttackStruct(n: "Tackle", dmg: 2),
        missChance: 2,
        enemyImage: UIImage(named: "PigBig")!,
        crySoundName: "Pig Cry",
        souls: 1,
        timesDefeated: 0)
    
    static var spellbook = EnemyStruct(
        name: "Possessed Spellbook",
        totalHealth: 25,
        currentHealth: 25,
        attack1: AttackStruct(n: "Spectral Force", dmg: 7),
        attack2: AttackStruct(n: "Eerie Spell", dmg: 2),
        missChance: 3,
        enemyImage: UIImage(named: "SpellbookBig")!,
        crySoundName: "Spellbook Cry",
        souls: 2,
        timesDefeated: 0)
}


