//
//  ResultViewController.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 04/04/2023.
//

import UIKit
import AVFoundation

class ResultViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var finalSoulQtyLabel: UILabel!
    @IBOutlet weak var finalDiamondQtyLabel: UILabel!
    @IBOutlet weak var finalGoldQtyLabel: UILabel!
    @IBOutlet weak var finalDirtQtyLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    

    var message = ""
    
    var totSoulPts = 0
    var totDiamondPts = 0
    var totGoldPts = 0
    var totDirtPts = 0
    
    var music: AVAudioPlayer!
    var song = ""
    
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadStats()
        playSound(soundName: song)
        messageLabel.text = message

        totSoulPts = Items.soul.qty * Items.soul.value
        totDiamondPts = Items.diamond.qty * Items.diamond.value
        totGoldPts = Items.gold.qty * Items.gold.value
        totDirtPts = Items.dirt.qty * Items.dirt.value
        
        finalSoulQtyLabel.text = "\(Items.soul.qty) x \(Items.soul.value) = \(totSoulPts)"
        finalDiamondQtyLabel.text = "\(Items.diamond.qty) x \(Items.diamond.value) = \(totDiamondPts)"
        finalGoldQtyLabel.text = "\(Items.gold.qty) x \(Items.gold.value) = \(totGoldPts)"
        finalDirtQtyLabel.text = "\(Items.dirt.qty) x \(Items.gold.value) = \(totDirtPts)"
        
        let result = totSoulPts + totDiamondPts + totGoldPts + totDirtPts
        
        resultLabel.text = String(result)
        resultLabel.layer.borderColor = CGColor(gray: 1, alpha: 1)
        resultLabel.layer.borderWidth = 4
        resultLabel.layer.cornerRadius = 50
        
        PlayerStats.overallStats["Points"] = result + PlayerStats.overallStats["Points"]!
        PlayerStats.overallStats["Total souls collected"] = Items.soul.qty + PlayerStats.overallStats["Total souls collected"]!
        PlayerStats.overallStats["Total diamonds collected"] = Items.diamond.qty + PlayerStats.overallStats["Total diamonds collected"]!
        PlayerStats.overallStats["Total gold collected"] = Items.gold.qty + PlayerStats.overallStats["Total gold collected"]!
        PlayerStats.overallStats["Total dirt collected"] = Items.dirt.qty + PlayerStats.overallStats["Total dirt collected"]!
        PlayerStats.overallStats["Mutant Pigs defeated"] = AllEnemies.pig.timesDefeated + PlayerStats.overallStats["Mutant Pigs defeated"]!
        PlayerStats.overallStats["Possessed Spellbooks defeated"] = AllEnemies.spellbook.timesDefeated + PlayerStats.overallStats["Possessed Spellbooks defeated"]!
        
        if song == "Win Screen" {
            PlayerStats.overallStats["Successful escapes"]! += 1
        } else {
            PlayerStats.overallStats["Deaths"]! += 1
        }
        
        if result > PlayerStats.overallStats["Highest score"]! {
            PlayerStats.overallStats["Highest score"] = result
        }
        
        defaults.set(PlayerStats.overallStats, forKey: "playerStats")
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        music = try! AVAudioPlayer(contentsOf: url!)
        music.play()
    }
    
    func loadStats() {
        if let playerStats = defaults.object(forKey: "playerStats") as? [String : Int] {
            PlayerStats.overallStats = playerStats
        }
    }
}
