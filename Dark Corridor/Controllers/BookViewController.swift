//
//  OrcViewController.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 03/04/2023.
//

import UIKit
import AVFoundation

class BookViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var slashButton: UIButton!
    @IBOutlet weak var chargeButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var potionButton: UIButton!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var playerBattleImage: UIImageView!
    
    @IBOutlet weak var playerHP: UILabel!
    @IBOutlet weak var enemyHP: UILabel!
    
    @IBOutlet weak var enemyImage: UIImageView!
    
    var playerName = ""
    var battleImage = ""
    var character1 = Character()
    var book = BigEnemy()
    var items = Items()
    var potionQty = 0
    var attackName = ""
    var playerAtk = ""
    
    var music: AVAudioPlayer!
    var music2: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound(soundName: "Battle Music")
        
        messageLabel.text = "Prepare to fight! Choose an Attack"
        exitButton.isEnabled = false
        name.text = playerName
        playerBattleImage.image = UIImage(named: battleImage)
        playerHP.text = "HP: \(character1.currentHealth) / \(character1.health)"
        enemyHP.text = "HP: \(book.currentHealth) / \(book.health)"
        if character1.currentHealth == character1.health {
            potionButton.isEnabled = false
        } else {
            potionButton.isEnabled = true
        }
        potionButton.setTitle("USE POTION: \(potionQty)", for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            playSoundFx(soundname: "Spellbook Cry")
        }
    }
    
    @IBAction func attackIsPressed(_ sender: UIButton) {
        
        if sender.currentTitle == "SLASH" {
            messageLabel.text = "You used slash for 5 damage!"
            character1.damage = character1.attacks["Slash"]!
            playerAtk =  "Slash"
 
        } else if sender.currentTitle == "CHARGE" {
            messageLabel.text = "You charged for 3 damage!"
            character1.damage = character1.attacks["Charge"]!
            playerAtk =  "Charge"
          
        } else {
            
            character1.damage = 0
        }
        slashButton.isEnabled = false
        chargeButton.isEnabled = false
        potionButton.isEnabled = false
        
        if character1.damage > 0 {
            
            if character1.attackWorks() {
                playSoundFx(soundname: playerAtk)
                book.currentHealth -= character1.damage
                enemyHP.text = "HP: \(book.currentHealth) / \(book.health)"
                character1.animateText(enemyHP, .red)
                if book.currentHealth <= 0 {
                    
                    battleWin()
                    
                } else if book.currentHealth > 0 {

                        enemyAttacks()
                    }
                
            } else {
                messageLabel.text = "You missed your attack!"
                enemyAttacks()
            }
        } else {
            usePotion()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
                enemyAttacks()
            }
        }
        
    }
    
    func usePotion() {
        playSoundFx(soundname: "Potion")
        potionQty -= 1
        potionButton.setTitle("USE POTION: \(potionQty)", for: .normal)
        if character1.health - character1.currentHealth >= items.potionPower {
            character1.currentHealth += items.potionPower
            messageLabel.text = "You drank a potion for \(items.potionPower) HP"
        } else {
            messageLabel.text = "You drank a potion for \(character1.health - character1.currentHealth) HP"
            character1.currentHealth = character1.health
        }
        playerHP.text = "HP: \(character1.currentHealth) / \(character1.health)"
        character1.animateText(playerHP, .green)
    }
    
    func loopFight() {
        
        messageLabel.text = "Choose an attack"
        slashButton.isEnabled = true
        chargeButton.isEnabled = true
        if potionQty > 0 && character1.currentHealth < character1.health {
            potionButton.isEnabled = true
        } else if potionQty == 0 || character1.currentHealth == character1.health {
            potionButton.isEnabled = false
        }
    }
    
    func enemyAttacks() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
            messageLabel.text = "The spellbook prepares to attack..."
        }
        if book.attackMissed() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { [self] in
                messageLabel.text = "The spellbook tried to attack but failed!"
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) { [self] in
                loopFight()
            }
        } else {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { [self] in
                let enemyDamage = book.fight()
                if enemyDamage == book.attacks["Spectral Force"] {
                    attackName = "Spectral Force"
                    playSoundFx(soundname: "Spectral Force")
                } else if enemyDamage == book.attacks["Eerie Spell"] {
                    attackName = "Eerie Spell"
                    playSoundFx(soundname: "Eerie Spell")
                }
                
                messageLabel.text = "The spellbook used \(attackName) for \(enemyDamage) damage!"
                character1.currentHealth -= enemyDamage
                playerHP.text = "HP: \(character1.currentHealth) / \(character1.health)"
                character1.animateText(playerHP, .red)
                
                if character1.currentHealth <= 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
                        playerBattleImage.alpha = 0
                        messageLabel.text = "You're dead..."
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { [self] in
                        self.performSegue(withIdentifier: "goToResult", sender: self)
                    }
                    
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
                        loopFight()
                    }
                }
            }
        }
    }
    
    func battleWin() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
            playSound(soundName: "Battle Win")
            enemyImage.alpha = 0
            messageLabel.text = "Woo-hoo! You defeated the possessed spellbook!"
            items.allItems[0].qty += 2
            slashButton.isEnabled = false
            chargeButton.isEnabled = false
            potionButton.isEnabled = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { [self] in
            messageLabel.text = "You got the spellbook's soul!"
            exitButton.isEnabled = true
        }
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        music = try! AVAudioPlayer(contentsOf: url!)
        music.play()
    }
   
    func playSoundFx(soundname: String) {
        let url = Bundle.main.url(forResource: soundname, withExtension: "mp3")
        music2 = try! AVAudioPlayer(contentsOf: url!)
        music2.play()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.message = "You died..."
            destinationVC.finalSoulQty = 0
            destinationVC.finalDiamondQty = 0
            destinationVC.finalGoldQty = 0
            destinationVC.finalDirtQty = 0
            destinationVC.song = "Dead Screen"
            music.stop()
            
        } else {
            let destinationVC = segue.destination as! MainViewController
            destinationVC.items.allItems[0].qty = items.allItems[0].qty
            destinationVC.updatedHealth = character1.currentHealth
            destinationVC.exitButton.isEnabled = true
            destinationVC.potionQty = potionQty
            destinationVC.messageLabel.text = ""
            music.stop()
            destinationVC.playSound()
        }
    }
}



