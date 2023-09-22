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
        PlayerStats.possessedSpellbooksDefeated
    ]
    
    var allStatsRealm: Results<StatClass>?
    
    var message = ""
    
    var totSoulPts = 0
    var totDiamondPts = 0
    var totGoldPts = 0
    var totDirtPts = 0
    
    var music: AVAudioPlayer!
    var song = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playSound(soundName: song)
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
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        music = try! AVAudioPlayer(contentsOf: url!)
        music.play()
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
        PlayerStats.mutantPigsDefeated.value = AllEnemies.pig.timesDefeated + PlayerStats.mutantPigsDefeated.value
        PlayerStats.possessedSpellbooksDefeated.value = AllEnemies.spellbook.timesDefeated + PlayerStats.possessedSpellbooksDefeated.value
        
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
}

