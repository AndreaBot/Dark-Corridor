//
//  TableViewController.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 08/04/2023.
//

import UIKit
import AVFoundation

class InventoryViewController: UIViewController {
    
    
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var potionQtyLabel: UILabel!
    @IBOutlet weak var usePotionButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let allItems = [Items.soul, Items.diamond, Items.gold, Items.dirt]
    var item = Items()
    
    var music: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hpLabel.text = "\(Character.playerName!)'s HP \(Character.currentHealth) / \(Character.health)"
        potionQtyLabel.text = "Potions: \(Items.potion.qty)"
        
        if Items.potion.qty == 0 || Character.currentHealth == Character.health {
            usePotionButton.isEnabled = false
        } else if Items.potion.qty > 0 && Character.currentHealth < Character.health {
            usePotionButton.isEnabled = true
        }
        messageLabel.text = ""
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "InventoryCell", bundle: nil), forCellReuseIdentifier: "inventoryCell")
    }
    
    @IBAction func usePotionIsPressed(_ sender: UIButton) {
        
        hpLabel.text = "\(Character.playerName!)'s"
        item.usePotion(messageLabel, hpLabel, potionQtyLabel, nil)
        if Items.potion.qty < 0 || Character.currentHealth == Character.health {
            usePotionButton.isEnabled = false
        } else {
            usePotionButton.isEnabled = true
        }
    }
    
    @IBAction func exitInventory(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}


extension InventoryViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension InventoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let itemsWithQuantity = allItems.filter { $0.qty > 0 }

        return itemsWithQuantity.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inventoryCell", for: indexPath) as! InventoryCell
        
        let itemsWithQuantity = allItems.filter { $0.qty > 0 }
        let itemName = itemsWithQuantity[indexPath.row].name
        let quantity = itemsWithQuantity[indexPath.row].qty
        cell.itemName.text = itemName
        cell.itemQuantity.text = "x\(quantity)"
        cell.itemImage.image = UIImage(named: itemName)
        cell.itemName.textAlignment = .left

        cell.stackView.distribution = .fillEqually
        
        return cell
    }
}


    
    
