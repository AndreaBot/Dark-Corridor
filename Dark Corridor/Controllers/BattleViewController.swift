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
    
    var item = Items()
    var battleImage = ""
    var spawnedEnemy: EnemyStruct?
    var character1 = Character()
    var items = Items()
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
        name.text = Character.playerName ?? "Player"
        playerBattleImage.image = UIImage(named: battleImage)
        playerHP.text = "HP: \(Character.currentHealth) / \(Character.health)"
        
        enemyHP.text = "HP: \(spawnedEnemy!.currentHealth) / \(spawnedEnemy!.totalHealth)"
        enemyImage.image = spawnedEnemy!.enemyImage
        
        if Character.currentHealth == Character.health || Items.potion.qty == 0 {
            potionButton.isEnabled = false
        } else if Character.currentHealth < Character.health && Items.potion.qty > 0 {
            potionButton.isEnabled = true
        }
        potionButton.setTitle("USE POTION: \(Items.potion.qty)", for: .normal)
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
                Character.animateText(enemyHP, .red)
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
            playerHP.text = ""
            item.usePotion(messageLabel, playerHP, nil, potionButton)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
                enemyAttacks()
            }
        }
    }
    
    func loopFight() {
        
        messageLabel.text = "Choose an attack"
        slashButton.isEnabled = true
        chargeButton.isEnabled = true
        if Items.potion.qty > 0 && Character.currentHealth < Character.health {
            potionButton.isEnabled = true
        } else if Items.potion.qty == 0 || Character.currentHealth == Character.health {
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
                Character.currentHealth -= enemyDamage
                playerHP.text = "HP: \(Character.currentHealth) / \(Character.health)"
                Character.animateText(playerHP, .red)
                
                if Character.currentHealth <= 0 {
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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.message = "You died"
            items.resetQtys()
            destinationVC.song = "Dead Screen"
            music.stop()
            
            
        } else {
            let destinationVC = segue.destination as! MainViewController
            destinationVC.exitButton.isEnabled = true
            destinationVC.messageLabel.text = ""
            music.stop()
            destinationVC.playSound()
        }
    }
}
