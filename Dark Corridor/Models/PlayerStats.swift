//
//  PlayerStats.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 17/09/2023.
//

import Foundation
import RealmSwift

struct PlayerStats {

    static var points = StatClass(name: "Points", value: 0, category: "General")
    static var highestScore = StatClass(name: "Highest score", value: 0, category: "General")
    static var successfulEscapes = StatClass(name: "Successful escapes", value: 0, category: "General")
    static var deaths = StatClass(name: "Deaths", value: 0, category: "General")
    static var soulsCollected = StatClass(name: "Souls collected", value: 0, category: "Loot")
    static var diamondsCollected = StatClass(name: "Diamonds collected", value: 0, category: "Loot")
    static var goldCollected = StatClass(name: "Gold collected", value: 0, category: "Loot")
    static var dirtCollected = StatClass(name: "Dirt collected", value: 0, category: "Loot")
    static var mutantPigsDefeated = StatClass(name: "Mutant Pigs defeated", value: 0, category: "Enemies")
    static var possessedSpellbooksDefeated = StatClass(name: "Possessed Spellbooks defeated", value: 0, category: "Enemies")
    static var hornedBatDefeated = StatClass(name: "Horned Bats defeated", value: 0, category: "Enemies")
    
}
