//
//  ResultViewController.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 04/04/2023.
//

import UIKit
import AVFoundation
import RealmSwift

class ResultViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var finalSoulQtyLabel: UILabel!
    @IBOutlet weak var finalDiamondQtyLabel: UILabel!
    @IBOutlet weak var finalGoldQtyLabel: UILabel!
    @IBOutlet weak var finalDirtQtyLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    let realm = try! Realm()
    var allStats = [
        PlayerStats.points,
        PlayerStats.highestScore,
        PlayerStats.successfulEscapes,
        PlayerStats.deaths,
        PlayerStats.soulsCollected,
        PlayerStats.diamondsCollected,
        PlayerStats.goldCollected,
        PlayerStats.dirtCollected,
        PlayerStats.mutantPigsDefeated,
        PlayerStats.possessedSpellbooksDefeated,
        PlayerStats.hornedBatDefeated,
        PlayerStats.deathsEmissaryDefeated,
        PlayerStats.creepyLadiesDefeated
    ]
    
    var allStatsRealm: Results<StatClass>?
    
    var items = Items()
    var message = ""
    
    var totSoulPts = 0
    var totDiamondPts = 0
    var totGoldPts = 0
    var totDirtPts = 0
    
    var music: AVAudioPlayer!
    var song = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        SharedCode.Audio.playSound(song)
        messageLabel.text = message
        let result = calculatePoints()
        
        finalSoulQtyLabel.text = "\(Items.soul.qty) x \(Items.soul.value) = \(totSoulPts)"
        finalDiamondQtyLabel.text = "\(Items.diamond.qty) x \(Items.diamond.value) = \(totDiamondPts)"
        finalGoldQtyLabel.text = "\(Items.gold.qty) x \(Items.gold.value) = \(totGoldPts)"
        finalDirtQtyLabel.text = "\(Items.dirt.qty) x \(Items.gold.value) = \(totDirtPts)"
        
        resultLabel.text = String(result)
        resultLabel.layer.borderColor = CGColor(gray: 1, alpha: 1)
        resultLabel.layer.borderWidth = 4
        resultLabel.layer.cornerRadius = 50
        
        do {
            try self.realm.write {
                allStatsRealm = realm.objects(StatClass.self)
                
                if allStatsRealm!.count > 0 {
                    for (index, result) in allStatsRealm!.enumerated() {
                        allStats[index].value = result.value
                    }
                }
                updateStatsValues(result)
                updateRealm()
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        AllEnemies.mutantPig.timesDefeated = 0
        AllEnemies.possessedSpellbook.timesDefeated = 0
        AllEnemies.hornedBat.timesDefeated = 0
        AllEnemies.deathsEmissary.timesDefeated = 0
        AllEnemies.creepyLady.timesDefeated = 0
        
        items.resetQtys()
        StoreItems.allItems[3].isPurchased = false
        StoreItems.allItems[2].qty = Items.potion.qty
        SharedCode.PList.saveItems()
        
        Character.currentHealth = Character.health
        Character.up = 0
        Character.attack1.damage = 5
        Character.attack2.damage = 3
    }
    
    func calculatePoints() -> Int {
        totSoulPts = Items.soul.qty * Items.soul.value
        totDiamondPts = Items.diamond.qty * Items.diamond.value
        totGoldPts = Items.gold.qty * Items.gold.value
        totDirtPts = Items.dirt.qty * Items.dirt.value
        return totSoulPts + totDiamondPts + totGoldPts + totDirtPts
    }
    
    func updateStatsValues(_ result: Int) {
        PlayerStats.points.value = result + PlayerStats.points.value
        PlayerStats.soulsCollected.value = Items.soul.qty + PlayerStats.soulsCollected.value
        PlayerStats.diamondsCollected.value = Items.diamond.qty + PlayerStats.diamondsCollected.value
        PlayerStats.goldCollected.value = Items.gold.qty + PlayerStats.goldCollected.value
        PlayerStats.dirtCollected.value = Items.dirt.qty + PlayerStats.dirtCollected.value
        PlayerStats.mutantPigsDefeated.value = AllEnemies.mutantPig.timesDefeated + PlayerStats.mutantPigsDefeated.value
        PlayerStats.possessedSpellbooksDefeated.value = AllEnemies.possessedSpellbook.timesDefeated + PlayerStats.possessedSpellbooksDefeated.value
        PlayerStats.hornedBatDefeated.value = AllEnemies.hornedBat.timesDefeated + PlayerStats.hornedBatDefeated.value
        PlayerStats.deathsEmissaryDefeated.value = AllEnemies.deathsEmissary.timesDefeated + PlayerStats.deathsEmissaryDefeated.value
        PlayerStats.creepyLadiesDefeated.value = AllEnemies.creepyLady.timesDefeated + PlayerStats.creepyLadiesDefeated.value
        
        if song == "Win Screen" {
            PlayerStats.successfulEscapes.value += 1
        } else {
            PlayerStats.deaths.value += 1
        }
        
        if result > PlayerStats.highestScore.value {
            PlayerStats.highestScore.value = result
        }
    }
    
    func updateRealm() {
        for stat in allStats {
            if let existingStat = allStatsRealm!.filter("name == %@", stat.name).first {
                existingStat.value = stat.value
            } else {
                realm.add(stat)
            }
        }
    }
    
    @IBAction func backToStart(_ sender: UIButton) {
        SharedCode.Audio.playSound("Main Menu")
        
    }
    
}

