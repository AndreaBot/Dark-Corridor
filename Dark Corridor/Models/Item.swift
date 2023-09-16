//
//  Item.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 26/03/2023.
//

import Foundation
import AVFoundation

struct Items {
    
    var player2: AVAudioPlayer!
    
    var potionPower = 15
    
    var allItems = [ ItemStruct(t: "Soul", q: 0, v: 5),
                     ItemStruct(t: "Diamond", q: 0, v: 10),
                     ItemStruct(t: "Gold", q: 0, v: 3),
                     ItemStruct(t: "Dirt", q: 0, v: 1)
    ]
    
    var foundText = ""
    
    mutating func plusSoul() {
        allItems[0].qty += 1
    }
    
    mutating func plusDiamond() {
        allItems[1].qty += 1
    }
    
    mutating func plusGold() {
        allItems[2].qty += 1
    }
    
    mutating func plusDirt() {
        allItems[3].qty += 1
    }
    
    mutating func itemFound()  {
    
        let itemFound = Int.random(in: 1...10)
        
       if itemFound <= 6 {
            plusDirt()
            foundText = "You found dirt..."
        playSoundFx(soundname: "Dirt")
        } else if itemFound > 6 && itemFound <= 9 {
            plusGold()
            foundText = "You found gold!"
            playSoundFx(soundname: "Coin")
        } else if itemFound == 10 {
            plusDiamond()
            playSoundFx(soundname: "Diamond")
            foundText = "You found a diamond!"
        }
    }
    
    mutating func playSoundFx(soundname: String) {
        let url = Bundle.main.url(forResource: soundname, withExtension: "mp3")
        player2 = try! AVAudioPlayer(contentsOf: url!)
        player2.play()
    }
}


