//
//  StoryViewController.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 04/04/2023.
//

import UIKit
import AVFoundation

class SettingsViewController: UIViewController {
    
    var playerName: String?
    var playerBack = ""
    var playerLeft = ""
    var playerRight = ""
    var colorExit = ""
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var redHero: UIButton!
    @IBOutlet weak var blueHero: UIButton!
    
    var music: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redHero.alpha = 0.6
        blueHero.alpha = 0.6
        continueButton.isEnabled = false
        
        let exitKeyboard = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
               view.addGestureRecognizer(exitKeyboard)
    }
    
    
    @IBAction func heroSelected(_ sender: UIButton) {
        if sender.currentTitle == "red" {
            redHero.alpha = 1
            blueHero.alpha = 0.6
             playerBack = "RedHeroBack"
             playerLeft = "RedHeroLeft"
             playerRight = "RedHeroRight"
             colorExit = "Red Exit"
        } else if sender.currentTitle == "blue" {
            blueHero.alpha = 1
            redHero.alpha = 0.6
             playerBack = "BlueHeroBack"
             playerLeft = "BlueHeroLeft"
             playerRight = "BlueHeroRight"
             colorExit = "Blue Exit"
        }
        continueButton.isEnabled = true
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        
        playerName = nameField.text
           if playerName == "" {
               playerName = "Player"
           }
        music.stop()
        self.performSegue(withIdentifier: "goToGame", sender: self)

    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            let destinationVC = segue.destination as! MainViewController
            destinationVC.playerName = playerName
            destinationVC.playerBack = playerBack
            destinationVC.playerLeft = playerLeft
            destinationVC.playerRight = playerRight
            destinationVC.colorExit = colorExit
        }
    }
}
