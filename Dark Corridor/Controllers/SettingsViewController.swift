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
    @IBOutlet weak var greenHero: UIButton!
    @IBOutlet weak var darkHero: UIButton!

    
    var playerBack = "" {
        didSet {
            continueButton.isEnabled = true
        }
    }
    var playerLeft = ""
    var playerRight = ""
    var colorExit = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        redHero.alpha = 0.6
        blueHero.alpha = 0.6
        greenHero.alpha = 0.6
        darkHero.alpha = 0.6
        continueButton.isEnabled = false

        let exitKeyboard = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(exitKeyboard)
    }
    
    
    @IBAction func heroSelected(_ sender: UIButton) {
        
        switch sender.currentTitle {
        case "red": setRedHero()
        case "blue": setBlueHero()
        case "green": StoreItems.allItems[0].isPurchased ? setGreenHero() : present(SharedCode.Alerts.showOkAlert("Alert", "Buy this Hero from the store to unlock it!"), animated: true)
        case "dark": StoreItems.allItems[1].isPurchased ? setDarkHero() : present(SharedCode.Alerts.showOkAlert("Alert", "Buy this Hero from the store to unlock it!"), animated: true)
        case .none: setRedHero()
        case .some(_): setRedHero()
        }
    }
    
    func setRedHero() {
        redHero.alpha = 1
        blueHero.alpha = 0.6
        greenHero.alpha = 0.6
        darkHero.alpha = 0.6
        playerBack = "RedHeroBack"
        playerLeft = "RedHeroLeft"
        playerRight = "RedHeroRight"
        colorExit = "Red Exit"
    }
    
    func setBlueHero() {
        blueHero.alpha = 1
        redHero.alpha = 0.6
        greenHero.alpha = 0.6
        darkHero.alpha = 0.6
        playerBack = "BlueHeroBack"
        playerLeft = "BlueHeroLeft"
        playerRight = "BlueHeroRight"
        colorExit = "Blue Exit"
    }
    
    func setGreenHero() {
        greenHero.alpha = 1
        redHero.alpha = 0.6
        blueHero.alpha = 0.6
        darkHero.alpha = 0.6
        playerBack = "GreenHeroBack"
        playerLeft = "GreenHeroLeft"
        playerRight = "GreenHeroRight"
        colorExit = "Green Exit"
    }
    
    func setDarkHero() {
        darkHero.alpha = 1
        redHero.alpha = 0.6
        blueHero.alpha = 0.6
        greenHero.alpha = 0.6
        playerBack = "DarkHeroBack"
        playerLeft = "DarkHeroLeft"
        playerRight = "DarkHeroRight"
        colorExit = "Dark Exit"
    }

    
    @IBAction func continuePressed(_ sender: UIButton) {
        
        Character.playerName = nameField.text!
        if Character.playerName == "" {
            Character.playerName = "Player"
        }
        SharedCode.Audio.musicPlayer.stop()
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
