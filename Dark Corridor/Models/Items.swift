//
//  Item.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 26/03/2023.
//

import UIKit

struct Items {
    
    static var potion = ItemStruct(name: "Potion", qty: 2, value: 15)
    static var powerUp = ItemStruct(name: "Power Up", qty: 0, value: 3)
    
    static var soul = ItemStruct(name: "Soul", qty: 0, value: 5)
    static var diamond = ItemStruct(name: "Diamond", qty: 0, value: 10)
    static var gold = ItemStruct(name: "Gold", qty: 0, value: 3)
    static var dirt = ItemStruct(name: "Dirt", qty: 0, value: 1)
    
    static var foundText = ""
    
    func addLoot(_ loot: ItemStruct) {
        switch loot.name {
        case "Souls" : Items.soul.qty += 1;
        case "Diamond" : Items.diamond.qty += 1; Items.foundText = "You found a diamond!";
        case "Gold" : Items.gold.qty += 1; Items.foundText = "You found gold!";
        case "Dirt" : Items.dirt.qty += 1; Items.foundText = "You found dirt...";
        case "Potion" : Items.potion.qty += 1; Items.foundText = "You found a potion!";
        case "Power Up" : Items.powerUp.qty += 1; Items.foundText = "You found a Power Up! Attacks damage increased by \(Items.powerUp.value)"
            Character.attack1.damage += 3; Character.attack2.damage += 3;
            
        default:
            print("item qty can't be updated")
        }
    }
    
    mutating func itemFound()  {
        
        let itemFound = Int.random(in: 1...12)
        
        if itemFound <= 6 {
            addLoot(Items.dirt)
            SharedCode.Audio.playSoundFx("Dirt")
        } else if itemFound > 6 && itemFound <= 9 {
            addLoot(Items.gold)
            SharedCode.Audio.playSoundFx("Coin")
        } else if itemFound == 10 {
            addLoot(Items.diamond)
            SharedCode.Audio.playSoundFx("Diamond")
        } else if itemFound == 11 {
            addLoot(Items.potion)
            SharedCode.Audio.playSoundFx("General Item")
        } else if itemFound == 12 && Items.powerUp.qty == 0 {
            addLoot(Items.powerUp)
            SharedCode.Audio.playSoundFx("Power Up")
            Items.powerUp.qty = 1
        } else if itemFound == 12 && Items.powerUp.qty == 1 {
            addLoot(Items.dirt)
            SharedCode.Audio.playSoundFx("Dirt")
        }
    }
    
    mutating func resetQtys() {
        if Items.potion.qty <= 2 {
            Items.potion.qty = 2
        }
        Items.soul.qty = 0
        Items.diamond.qty = 0
        Items.gold.qty = 0
        Items.dirt.qty = 0
        Items.powerUp.qty = 0
    }
    
    mutating func usePotion(_ messageLabel: UILabel, _ hpLabel: UILabel, _ potionQtyLabel: UILabel?, _ potionButton: UIButton?) {
        SharedCode.Audio.playSoundFx("Potion")
        Items.potion.qty -= 1
        SharedCode.animateText(hpLabel, .green)
        
        if Character.health - Character.currentHealth >= Items.potion.value {
            messageLabel.text = "You drank a potion for \(Items.potion.value) HP"
            Character.currentHealth += Items.potion.value
        } else {
            messageLabel.text = "You drank a potion for \(Character.health - Character.currentHealth) HP"
            Character.currentHealth = Character.health
        }
        hpLabel.text?.append(contentsOf: " HP \(Character.currentHealth) / \(Character.health)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            messageLabel.text = ""
        }
        
        potionQtyLabel?.text = "Potions: \(Items.potion.qty)"
        potionButton?.setTitle("USE POTION: \(Items.potion.qty)", for: .normal)
    }
}


