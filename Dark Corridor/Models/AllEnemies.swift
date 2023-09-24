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
    
    static var deathsEmissary = EnemyStruct(
        name: "Death's Emissary",
        totalHealth: 20,
        currentHealth: 20,
        attack1: AttackStruct(name: "Schyte Swing", damage: 6),
        attack2: AttackStruct(name: "Nightmare", damage: 4),
        missChance: 0,
        enemyImage: UIImage(named: "Death's Emissary")!,
        crySoundName: "Death's Emissary Cry",
        souls: 1,
        timesDefeated: 0)
    
    static var creepyLady = EnemyStruct(
        name: "Creepy Lady",
        totalHealth: 25,
        currentHealth: 25,
        attack1: AttackStruct(name: "Hair Whip", damage: 4),
        attack2: AttackStruct(name: "Phantom Shadows", damage: 7),
        missChance: 4,
        enemyImage: UIImage(named: "Creepy Lady")!,
        crySoundName: "Creepy Lady Cry",
        souls: 2,
        timesDefeated: 0)
}




