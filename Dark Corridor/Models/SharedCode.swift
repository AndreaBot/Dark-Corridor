//
//  SharedCode.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 05/10/2023.
//

import UIKit
import AVFoundation
import RealmSwift

struct SharedCode {
    
    static func animateText(_ UILabel: UILabel, _ color: UIColor)  {
        UILabel.textColor = color
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            UILabel.textColor = .white
        }
    }
    
    struct Alerts {
        
        static func showOkAlert(_ title: String, _ message: String) -> UIAlertController {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            return alert
        }
        
        static func purchaseAlert(_ item: String, _ price: Int, _ purchaseFunc: @escaping (String, Int) -> Void) -> UIAlertController {
            let alert = UIAlertController(title: item, message: "Are you sure you want to buy this item for \(price) points?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
            alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
                purchaseFunc(item, price)
            }))
            
            return alert
        }
    }
    
    struct Audio {
        
        static var musicPlayer: AVAudioPlayer!
        static var fxPlayer: AVAudioPlayer!
        
        static func playSound(_ fileName: String) {
            let url = Bundle.main.url(forResource: fileName, withExtension: "mp3")
            musicPlayer = try! AVAudioPlayer(contentsOf: url!)
            musicPlayer.play()
        }
        
        static func playSoundFx(_ fileName: String) {
            let url = Bundle.main.url(forResource: fileName, withExtension: "mp3")
            fxPlayer = try! AVAudioPlayer(contentsOf: url!)
            fxPlayer.play()
        }
    }
    
    struct PList {
        
        static let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: "StoreItems.plist")
        
        static func loadItems() {
            if let data = try? Data(contentsOf: dataFilePath!) {
                let decoder = PropertyListDecoder()
                do {
                    StoreItems.allItems = try decoder.decode([StoreItemStruct].self, from: data)
                } catch {
                    print("error decoding item array, \(error)")
                }
            } else {
                return
            }
        }
        
        static func saveItems() {
            let encoder = PropertyListEncoder()
            do {
                let data = try encoder.encode(StoreItems.allItems)
                try data.write(to: dataFilePath!)
            } catch {
                print("error encoding item array, \(error)")
            }
        }
    }
}


