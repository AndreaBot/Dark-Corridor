//
//  StoryViewController.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 04/04/2023.
//

import UIKit
import AVFoundation

class SettingsViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var redHero: UIButton!
    @IBOutlet weak var blueHero: UIButton!
    
    var playerBack = ""
    var playerLeft = ""
    var playerRight = ""
    var colorExit = ""
    
    var music: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
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
        
        Character.playerName = nameField.text!
        if Character.playerName == "" {
            Character.playerName = "Player"
           }
        music.stop()
        self.performSegue(withIdentifier: "goToGame", sender: self)

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type the hero's name"
            return false
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            let destinationVC = segue.destination as! MainViewController
            destinationVC.playerBack = playerBack
            destinationVC.playerLeft = playerLeft
            destinationVC.playerRight = playerRight
            destinationVC.colorExit = colorExit
        }
    }
}
