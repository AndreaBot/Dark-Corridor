//
//  StoreItems.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 25/09/2023.
//

import Foundation

struct StoreItems {
    
    static var allItems = [
        StoreItemStruct(itemImageName: "GreenHeroFront", itemName: "Green Hero", price: 1, isPurchased: false),
        StoreItemStruct(itemImageName: "DarkHeroFront", itemName: "Dark Hero", price: 2, isPurchased: false),
        StoreItemStruct(itemImageName: "Potion", itemName: "Potion", price: 3, isPurchased: false, qty: 2),
        StoreItemStruct(itemImageName: "PowerUp", itemName: "Power Up", price: 4, isPurchased: false)
    ]
}

