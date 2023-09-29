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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: "StoreItems.plist")
    
    var playerBack = ""
    var playerLeft = ""
    var playerRight = ""
    var colorExit = ""
    
    var music: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        
        nameField.delegate = self
        redHero.alpha = 0.6
        blueHero.alpha = 0.6
        greenHero.alpha = 0.6
        darkHero.alpha = 0.6
        continueButton.isEnabled = false
        
        greenHero.isEnabled = StoreItems.allItems[0].isPurchased ? true : false
        darkHero.isEnabled = StoreItems.allItems[1].isPurchased ? true : false
           
        let exitKeyboard = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(exitKeyboard)
    }
    
    
    @IBAction func heroSelected(_ sender: UIButton) {
        
        switch sender.currentTitle {
        case "red": setRedHero()
        case "blue": setBlueHero()
        case "green": setGreenHero()
        case "dark": setDarkHero()
        case .none: setRedHero()
        case .some(_): setRedHero()
        }
        continueButton.isEnabled = true
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
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                StoreItems.allItems = try decoder.decode([StoreItemStruct].self, from: data)
            } catch {
                print("error decoding item array, \(error)")
            }
        } else {
            return
        }
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
