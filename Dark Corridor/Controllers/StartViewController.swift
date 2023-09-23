//
//  StartViewController.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 04/04/2023.
//

import UIKit
import AVFoundation

class StartViewController: UIViewController {
    
    var music: AVAudioPlayer!
    var items = Items()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        AllEnemies.mutantPig.timesDefeated = 0
        AllEnemies.possessedSpellbook.timesDefeated = 0
        items.resetQtys()
        Character.currentHealth = Character.health
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "goToStory", sender: self)
    }
    
    @IBAction func unwindToStartViewController(_ sender: UIStoryboardSegue) {
        playSound()
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "Main Menu", withExtension: "mp3")
        music = try! AVAudioPlayer(contentsOf: url!)
        music.play()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToStory" {
            let destinationVC = segue.destination as! SettingsViewController
            destinationVC.music = music
            
        }
    }
}
