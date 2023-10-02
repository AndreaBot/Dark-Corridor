//
//  StoreItems.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 25/09/2023.
//

import Foundation

struct StoreItems {
    
    static var allItems = [

        StoreItemStruct(itemImageName: "GreenHeroFront", itemName: "Green Hero", price: 1, isPurchased: false, needsExplaining: false, explanation: nil),
        StoreItemStruct(itemImageName: "DarkHeroFront", itemName: "Dark Hero", price: 2, isPurchased: false, needsExplaining: false, explanation: nil),
        StoreItemStruct(itemImageName: "Potion", itemName: "Potion", qty: 0, price: 3, isPurchased: false, needsExplaining: true, explanation: "A restorative drink that heals you by \(Items.potion.value) HP.\nNOTE: You always start a game with 2 potions"),
        StoreItemStruct(itemImageName: "PowerUp", itemName: "Power Up", price: 4, isPurchased: false, needsExplaining: true, explanation: "Increase your attacks damage by 3 points. \nYou can only buy one of these per game"),
        StoreItemStruct(itemImageName: "SecondChance", itemName: "Second Chance", price: 4, isPurchased: false, needsExplaining: true, explanation: "Brings you back to life if you fall in battle. Single use, you can only hold one of these")
    ]
}


