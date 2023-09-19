//
//  Item.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 26/03/2023.
//

import UIKit
import AVFoundation

struct Items {
    
    var player2: AVAudioPlayer!
    
    static var potionPower = 15
    
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
            
        default:
            print("item qty can't be updated")
        }
    }
    
    mutating func itemFound()  {
        
        let itemFound = Int.random(in: 1...10)
        
        if itemFound <= 6 {
            addLoot(Items.dirt)
            playSoundFx(soundname: "Dirt")
        } else if itemFound > 6 && itemFound <= 9 {
            addLoot(Items.gold)
            playSoundFx(soundname: "Coin")
        } else if itemFound == 10 {
            addLoot(Items.diamond)
            playSoundFx(soundname: "Diamond")
        }
    }
    
    mutating func resetQtys() {
        Items.soul.qty = 0
        Items.diamond.qty = 0
        Items.gold.qty = 0
        Items.dirt.qty = 0
    }
    
    mutating func playSoundFx(soundname: String) {
        let url = Bundle.main.url(forResource: soundname, withExtension: "mp3")
        player2 = try! AVAudioPlayer(contentsOf: url!)
        player2.play()
    }
}


