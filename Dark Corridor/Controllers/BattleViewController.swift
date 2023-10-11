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
    
    
    @IBOutlet weak var enemyStackView: UIStackView!
    @IBOutlet weak var playerStackView: UIStackView!
    
    var item = Items()
    var battleImage = ""
    var spawnedEnemy: EnemyStruct?
    var items = Items()
    var attackName = ""
    var playerAtk = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        slashButton.isEnabled = false
        chargeButton.isEnabled = false

        spawnedEnemy = [AllEnemies.mutantPig, AllEnemies.possessedSpellbook, AllEnemies.hornedBat, AllEnemies.deathsEmissary, AllEnemies.creepyLady].randomElement()!
        
        spawnedEnemy!.currentHealth = spawnedEnemy!.totalHealth
        enemyNameLabel.text = spawnedEnemy!.name
        
        SharedCode.Audio.playSound("Battle Music")
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
        
        enemyImage.alpha = 0
        enemyHP.alpha = 0
        enemyNameLabel.alpha = 0
        
        playerBattleImage.alpha = 0
        playerHP.alpha = 0
        name.alpha = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [self] in
            CharacterAnimations.slideFromLeft(view, playerBattleImage, playerHP, name, playerStackView)
            EnemyStruct.spawnAnimation(spawnedEnemy!, view, enemyImage, enemyHP, enemyNameLabel, enemyStackView)

        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) { [self] in
            SharedCode.Audio.playSoundFx(spawnedEnemy!.crySoundName)
            slashButton.isEnabled = true
            chargeButton.isEnabled = true
            //potionButton.isEnabled = true
        }
    }
    
    @IBAction func attackIsPressed(_ sender: UIButton) {
        
        if sender.currentTitle == "SLASH" {
            messageLabel.text = "You used slash for \(Character.attack1.damage) damage!"
            Character.damage = Character.attack1.damage
            playerAtk =  "Slash"
 
        } else if sender.currentTitle == "CHARGE" {
            messageLabel.text = "You charged for \(Character.attack2.damage) damage!"
            Character.damage = Character.attack2.damage
            playerAtk =  "Charge"
          
        } else {
            Character.damage = 0
        }
        slashButton.isEnabled = false
        chargeButton.isEnabled = false
        potionButton.isEnabled = false
        
        if Character.damage > 0 {
            
            if Character.attackWorks() {
                SharedCode.Audio.playSoundFx(playerAtk)
                spawnedEnemy?.currentHealth -= Character.damage
                enemyHP.text = "HP: \(String(describing: spawnedEnemy!.currentHealth)) / \(String(describing: spawnedEnemy!.totalHealth))"
                SharedCode.animateText(enemyHP, .red)
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
                } else if enemyDamage == spawnedEnemy!.attack2.damage {
                    attackName = spawnedEnemy!.attack2.name
                }
                SharedCode.Audio.playSoundFx(attackName)
                
                messageLabel.text = "The \(spawnedEnemy!.name) used \(attackName) for \(enemyDamage) damage!"
                Character.currentHealth -= enemyDamage
                playerHP.text = "HP: \(Character.currentHealth) / \(Character.health)"
                SharedCode.animateText(playerHP, .red)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
                    if Character.currentHealth <= 0 {
                        if StoreItems.allItems[4].isPurchased == true {
                            triggerSecondChance()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
                                loopFight()
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                                SharedCode.Audio.playSound("Defeat")
                                CharacterAnimations.dropDown(playerStackView, playerBattleImage)
                                messageLabel.text = "You're dead..."
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
                                
                                self.performSegue(withIdentifier: "goToResult", sender: self)
                            }
                        }
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [self] in
                            loopFight()
                        }
                    }
                }
            }
        }
    }
        
    func battleWin() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [self] in
            CharacterAnimations.dropDown(enemyStackView, enemyImage)
            SharedCode.Audio.playSoundFx(spawnedEnemy!.crySoundName)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [self] in
            SharedCode.Audio.playSound("Battle Win")
            enemyImage.alpha = 0
            messageLabel.text = "Woo-hoo! You defeated the \(spawnedEnemy!.name)!"
            Items.soul.qty += spawnedEnemy!.souls
            slashButton.isEnabled = false
            chargeButton.isEnabled = false
            potionButton.isEnabled = false
            
            addDefeatedCount(spawnedEnemy!.name)
           
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) { [self] in
            messageLabel.text = "You got the \(spawnedEnemy!.name)'s soul!"
            exitButton.isEnabled = true
        }
    }
    
    
    func addDefeatedCount (_ enemyName: String) {
        switch enemyName {
        case "Mutant Pig": AllEnemies.mutantPig.timesDefeated += 1;
        case "Possessed Spellbook": AllEnemies.possessedSpellbook.timesDefeated += 1;
        case "Horned Bat": AllEnemies.hornedBat.timesDefeated += 1;
        case "Death's Emissary": AllEnemies.deathsEmissary.timesDefeated += 1;
        case "Creepy Lady": AllEnemies.creepyLady.timesDefeated += 1;
        default:
            print("Cant add stat")
        }
    }
    
    func triggerSecondChance() {
        Character.currentHealth = Character.health
        playerHP.text = "HP: \(Character.currentHealth) / \(Character.health)"
        SharedCode.animateText(playerHP, .yellow)
        SharedCode.Audio.playSoundFx("Second Chance")
        StoreItems.allItems[4].isPurchased = false
        messageLabel.text = "The second chance takes effect! Health fully restored."
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.message = "You died"
            items.resetQtys()
            destinationVC.song = "Dead Screen"
            
        } else {
            let destinationVC = segue.destination as! MainViewController
            destinationVC.exitButton.isEnabled = true
        }
    }
}
