//
//  ViewController.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 26/03/2023.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {
    
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var exitButton: UIButton!

    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet var path: [UIImageView]!
    @IBOutlet weak var exitTile: UIImageView!
    
    
    var playerName: String?
    var character1 = Character()
    var items = Items()

    var soul = 0
    
    var updatedHealth = 20
    var potionQty = 3
    
    var tagLeft = 0
    var tagRight = 0
    
    var playerBack = ""
    var playerLeft = ""
    var playerRight = ""
    var colorExit = ""
    
    var music: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound()
        messageLabel.text = ""
        exitButton.isEnabled = false
        
        for image in path {
            image.image = UIImage(named: "BlackTileNew")
        }
        path[character1.up].image = UIImage(named: playerBack)
    }
    
    @IBAction func moveUp(_ sender: UIButton) {
        if character1.up + 1 < 10 {
            character1.moveUp()
            
            for image in path {
                image.image = UIImage(named: "BlackTileNew")
            }
            path[character1.up].image = UIImage(named: playerBack)
            leftButton.isEnabled = true
            rightButton.isEnabled = true
            tagLeft = 0
            tagRight = 0
        } else {
            for image in path {
                image.image = UIImage(named: "BlackTileNew")
            }
            exitTile.image = UIImage(named: colorExit)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
                self.performSegue(withIdentifier: "goToResult", sender: self)
                messageLabel.text = ""
                exitButton.isEnabled = false
                upButton.isEnabled = false
                leftButton.isEnabled = false
                rightButton.isEnabled = false
            }
        }
    }
    
    
    @IBAction func roomEntered(_ sender: UIButton) {

        if sender.currentImage == UIImage(systemName: "arrowtriangle.backward") {
            path[character1.up].image = UIImage(named: playerLeft)
            tagLeft = 1
           
        } else if sender.currentImage == UIImage(systemName: "arrowtriangle.forward") {
            path[character1.up].image = UIImage(named: playerRight)
            tagRight = 2
    
        }
        leftButton.isEnabled = false
        rightButton.isEnabled = false
        upButton.isEnabled = false
        exitButton.isEnabled = true

        func randomFound() {
            let randomRoom = ["item", "enemy", "empty"]
            let randomResult = randomRoom.randomElement()
            if randomResult == "item" {
                items.itemFound()
                messageLabel.text = items.foundText
                
            } else if randomResult == "enemy" {
                messageLabel.text = "An enemy attacks you!"
                exitButton.isEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [self] in
                    self.performSegue(withIdentifier: "goToBattle", sender: self)
                }
            } else {
                messageLabel.text = "Nothing to see here..."
            }
        }
        randomFound()
    }
    
    @IBAction func exitRoom(_ sender: UIButton) {
        
        messageLabel.text = ""
        upButton.isEnabled = true
        path[character1.up].image = UIImage(named: playerBack)
        
        if tagLeft == 1 && tagRight == 0 {
            rightButton.isEnabled = true
        } else if tagRight == 2 && tagLeft == 0{
            leftButton.isEnabled = true
        }
        
        exitButton.isEnabled = false

    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "Main Game ", withExtension: "mp3")
        music = try! AVAudioPlayer(contentsOf: url!)
        music.play()
    }
    
    
    @IBAction func unwindToPreviousViewController(_ sender: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.message = "You escaped the Dark Corridor! \n\nHere is your loot:"
            destinationVC.finalSoulQty = items.allItems[0].qty
            destinationVC.finalDiamondQty = items.allItems[1].qty
            destinationVC.finalGoldQty = items.allItems[2].qty
            destinationVC.finalDirtQty = items.allItems[3].qty
            destinationVC.song = "Win Screen"
            music.stop()
    
        } else if segue.identifier == "goToBattle" {
            let destinationVC = segue.destination as! BattleViewController
            destinationVC.items.allItems[0].qty = items.allItems[0].qty
            destinationVC.character1.currentHealth = updatedHealth
            destinationVC.potionQty = potionQty
            destinationVC.playerName = playerName!
            if playerBack == "RedHeroBack" {
                destinationVC.battleImage = "RedHeroBackBig"
            } else if playerBack == "BlueHeroBack" {
                destinationVC.battleImage = "BlueHeroBackBig"
            }
            music.stop()
            
        } else if segue.identifier == "goToInventory" {
            let destinationVC = segue.destination as! InventoryViewController
            destinationVC.items.allItems[0].qty = items.allItems[0].qty
            destinationVC.items.allItems[1].qty = items.allItems[1].qty
            destinationVC.items.allItems[2].qty = items.allItems[2].qty
            destinationVC.items.allItems[3].qty = items.allItems[3].qty
            destinationVC.potionQty = potionQty
            destinationVC.character1.currentHealth = updatedHealth
            destinationVC.playerName = playerName
        }
    }
}


