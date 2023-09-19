//
//  BattleViewController.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 01/04/2023.
//

import UIKit
import AVFoundation

class BattleViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var slashButton: UIButton!
    @IBOutlet weak var chargeButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var enemyNameLabel: UILabel!
    @IBOutlet weak var playerBattleImage: UIImageView!
    @IBOutlet weak var playerHP: UILabel!
    @IBOutlet weak var enemyHP: UILabel!
    @IBOutlet weak var enemyImage: UIImageView!
    @IBOutlet weak var potionButton: UIButton!
    
    var playerName = ""
    var battleImage = ""
    var spawnedEnemy: EnemyStruct?
    var character1 = Character()
    var items = Items()
    var potionQty = 0
    var attackName = ""
    var playerAtk = ""
    
    var music: AVAudioPlayer!
    var music2: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spawnedEnemy = [AllEnemies.pig, AllEnemies.spellbook].randomElement()!
        spawnedEnemy!.currentHealth = spawnedEnemy!.totalHealth
        enemyNameLabel.text = spawnedEnemy!.name
        
        playSound(soundName: "Battle Music")
        messageLabel.text = "Prepare to fight! Choose an Attack"
        exitButton.isEnabled = false
        name.text = playerName
        playerBattleImage.image = UIImage(named: battleImage)
        playerHP.text = "HP: \(character1.currentHealth) / \(character1.health)"
        
        enemyHP.text = "HP: \(spawnedEnemy!.currentHealth) / \(spawnedEnemy!.totalHealth)"
        enemyImage.image = spawnedEnemy!.enemyImage
        
        if character1.currentHealth == character1.health || potionQty == 0 {
            potionButton.isEnabled = false
        } else if character1.currentHealth < character1.health && potionQty > 0 {
            potionButton.isEnabled = true
        }
        potionButton.setTitle("USE POTION: \(potionQty)", for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            playSoundFx(soundname: spawnedEnemy!.crySoundName)
            
        }
    }
    
    @IBAction func attackIsPressed(_ sender: UIButton) {
        
        if sender.currentTitle == "SLASH" {
            messageLabel.text = "You used slash for 5 damage!"
            character1.damage = character1.attack1.damage
            playerAtk =  "Slash"
 
        } else if sender.currentTitle == "CHARGE" {
            messageLabel.text = "You charged for 3 damage!"
            character1.damage = character1.attack2.damage
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
                spawnedEnemy?.currentHealth -= character1.damage
                enemyHP.text = "HP: \(String(describing: spawnedEnemy!.currentHealth)) / \(String(describing: spawnedEnemy!.totalHealth))"
                animateText(enemyHP, .red)
                if spawnedEnemy!.currentHealth <= 0 {
                    enemyHP.text = "HP: 0 / \(spawnedEnemy!.totalHealth)"
                    battleWin()
                        
                } else if spawnedEnemy!.currentHealth > 0 {
                
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
        if character1.health - character1.currentHealth >= Items.potionPower {
            character1.currentHealth += Items.potionPower
            messageLabel.text = "You drank a potion for \(Items.potionPower) HP"
        } else {
            messageLabel.text = "You drank a potion for \(character1.health - character1.currentHealth) HP"
            character1.currentHealth = character1.health
        }
        playerHP.text = "HP: \(character1.currentHealth) / \(character1.health)"
        animateText(playerHP, .green)
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
            messageLabel.text = "The \(spawnedEnemy!.name) prepares to attack..."
        }
        if spawnedEnemy!.attackMissed(spawnedEnemy!.missChance) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { [self] in
                messageLabel.text = "The \(spawnedEnemy!.name) tried to attack but failed!"
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) { [self] in
                loopFight()
            }
        } else {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { [self] in
                let enemyDamage = spawnedEnemy!.fight()
                if enemyDamage == spawnedEnemy!.attack1.damage {
                    attackName = spawnedEnemy!.attack1.name
                    playSoundFx(soundname: attackName)
                } else if enemyDamage == spawnedEnemy!.attack2.damage {
                    attackName = spawnedEnemy!.attack2.name
                    playSoundFx(soundname: attackName)
                }
                
                messageLabel.text = "The \(spawnedEnemy!.name) used \(attackName) for \(enemyDamage) damage!"
                character1.currentHealth -= enemyDamage
                playerHP.text = "HP: \(character1.currentHealth) / \(character1.health)"
                animateText(playerHP, .red)
                
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
            music.stop()
            playSound(soundName: "Battle Win")
            enemyImage.alpha = 0
            messageLabel.text = "Woo-hoo! You defeated the \(spawnedEnemy!.name)!"
            Items.soul.qty += spawnedEnemy!.souls
            slashButton.isEnabled = false
            chargeButton.isEnabled = false
            potionButton.isEnabled = false
            
            if spawnedEnemy?.name == "Mutant Pig" {
                AllEnemies.pig.timesDefeated += 1
            } else if spawnedEnemy?.name == "Possessed Spellbook" {
                AllEnemies.spellbook.timesDefeated += 1
            }
           
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { [self] in
            messageLabel.text = "You got the \(spawnedEnemy!.name)'s soul!"
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
    
    func animateText(_ UILabel: UILabel, _ color: UIColor)  {
        UILabel.textColor = color
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            UILabel.textColor = .white
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.message = "You died"
            items.resetQtys()
            destinationVC.song = "Dead Screen"
            music.stop()
            
            
        } else {
            let destinationVC = segue.destination as! MainViewController
            destinationVC.updatedHealth = character1.currentHealth
            destinationVC.exitButton.isEnabled = true
            destinationVC.potionQty = potionQty
            destinationVC.messageLabel.text = ""
            music.stop()
            destinationVC.playSound()
        }
    }
}
