//
//  TableViewController.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 08/04/2023.
//

import UIKit
import AVFoundation

class InventoryViewController: UIViewController {
    
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var potionQtyLabel: UILabel!
    @IBOutlet weak var usePotionButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var items = Items()
    var character1 = Character()
    var potionQty = 0
    var playerName: String?
    
    var music: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageLabel.text = "\(playerName ?? "Player")'s HP \(character1.currentHealth) / \(character1.health)"
        potionQtyLabel.text = "Potions: \(potionQty)"
        
        if potionQty == 0 || character1.currentHealth == character1.health {
            usePotionButton.isEnabled = false
        } else if potionQty > 0 && character1.currentHealth < character1.health {
            usePotionButton.isEnabled = true
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "InventoryCell", bundle: nil), forCellReuseIdentifier: "inventoryCell")
    }
    
    @IBAction func usePotionIsPressed(_ sender: UIButton) {
        
        usePotion()
        if potionQty < 0 || character1.currentHealth == character1.health {
            usePotionButton.isEnabled = false
        } else {
            usePotionButton.isEnabled = true
        }
    }
    
    func usePotion() {
        playSoundFx(soundname: "Potion")
        character1.animateText(messageLabel, .green)
        potionQty -= 1
        potionQtyLabel.text = "Potions: \(potionQty)"
        if character1.health - character1.currentHealth >= items.potionPower {
            character1.currentHealth += items.potionPower
            messageLabel.text = "\(playerName ?? "Player")'s HP \(character1.currentHealth) / \(character1.health)"
        } else {
            character1.currentHealth = character1.health
            messageLabel.text = "\(playerName ?? "Player")'s HP \(character1.currentHealth) / \(character1.health)"
        }
    }
    
    func playSoundFx(soundname: String) {
        let url = Bundle.main.url(forResource: soundname, withExtension: "mp3")
        music = try! AVAudioPlayer(contentsOf: url!)
        music.play()
    }
    
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    let destinationVC = segue.destination as! MainViewController
    destinationVC.potionQty = potionQty
    destinationVC.updatedHealth = character1.currentHealth
    }
}

extension InventoryViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension InventoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let itemsWithQuantity = items.allItems.filter { $0.qty > 0 }

        return itemsWithQuantity.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inventoryCell", for: indexPath) as! InventoryCell
        
        let itemsWithQuantity = items.allItems.filter { $0.qty > 0 }
        let itemName = itemsWithQuantity[indexPath.row].name
        let quantity = itemsWithQuantity[indexPath.row].qty
        cell.itemName.text = itemName
        cell.itemQuantity.text = "x\(quantity)"
        cell.itemImage.image = UIImage(named: itemName)
        return cell
    }
}


    
    
