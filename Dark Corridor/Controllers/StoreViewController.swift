//
//  StoreViewController.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 25/09/2023.
//

import UIKit
import RealmSwift

class StoreViewController: UIViewController {
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var storeTableView: UITableView!
    
    let realm = try! Realm()
    var realmStats: Results<StatClass>?
    
    var pointsAmount: Int = 0 {
        didSet {
            pointsLabel.text = "🟡 " + String(pointsAmount)
            PlayerStats.points.value = pointsAmount
        }
    }
    
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: "StoreItems.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
        do {
            try self.realm.write {
                realmStats = realm.objects(StatClass.self)
                pointsAmount = realmStats![0].value
            }
        } catch {
            print(error)
        }
        
        
        storeTableView.delegate = self
        storeTableView.dataSource = self
        storeTableView.register(UINib(nibName: "StoreCell", bundle: nil), forCellReuseIdentifier: "storeCell")
        storeTableView.rowHeight = 70
        
        StoreCell.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        do {
            if let stats = realmStats {
                let points = stats[0]
                try self.realm.write {
                    points.value = pointsAmount
                }
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    @IBAction func exitButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(StoreItems.allItems)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding item array, \(error)")
        }
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
}


extension StoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StoreItems.allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath) as! StoreCell
        let item = StoreItems.allItems[indexPath.row]
        
        cell.itemImage.image = UIImage(named: item.itemImageName)
        cell.itemNameLabel.text = item.itemName
        cell.itemPriceLabel.text = String(item.price)
        cell.explanationButton.alpha = item.itemName == "Power Up" ? 1 : 0
        cell.purchaseButton.isEnabled = item.isPurchased ? false : true
        if item.isPurchased == true && (item.itemName == "Green Hero" || item.itemName == "Dark Hero" || item.itemName == "Power Up")  {
            cell.purchaseButton.setTitle("√", for: .disabled)
            cell.purchaseButton.setTitleColor(.white, for: .disabled)
            cell.purchaseButton.layer.borderColor = CGColor(gray: 5, alpha: 0)
        } else {
            cell.purchaseButton.setTitle("BUY", for: .normal)
            cell.purchaseButton.layer.borderColor = CGColor(red: 0, green: 0.3, blue: 1, alpha: 1)
        }
        
        cell.purchaseButton.backgroundColor = .clear
        cell.purchaseButton.layer.borderWidth = 2
        cell.purchaseButton.layer.cornerRadius = cell.purchaseButton.frame.height/2
        cell.backgroundColor = .clear
        
        return cell
    }
}

extension StoreViewController: StoreCellDelegate {
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func processPurchase(_ item: String, _ price: Int) {
        
        if self.pointsAmount >= price {
            
            let alert = UIAlertController(title: item , message: "Are you sure you want to buy this item for \(price) points?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
            alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { confirm in
                self.confirmPurchase(item, price)
            }))
            present(alert, animated: true) }
        else {
            self.showAlert("Warning", "You do not have enough points to buy this item.")
        }
    }
    
    func confirmPurchase(_ item: String, _ price: Int) {
        
        do {
            try self.realm.write {
                pointsAmount -= price
            }
        } catch {
            print(error)
        }
        
        switch item {
        case "Green Hero": buyGreenHero();
        case "Dark Hero": buyDarkHero();
        case "Potion": buyPotion();
        case "Power Up": buyPowerUp()
        default:
            print("item not found")
        }
        
        func buyGreenHero() {
            StoreItems.allItems[0].isPurchased = true
            saveItems()
        }
        
        func buyDarkHero() {
           StoreItems.allItems[1].isPurchased = true
            saveItems()
        }
        
        func buyPotion() {
            saveItems()
            Items.additionalPotions += 1
        }
        
        func buyPowerUp() {
            StoreItems.allItems[3].isPurchased = true
            saveItems()
            Character.attack1.damage += 3; Character.attack2.damage += 3
        }
        
        storeTableView.reloadData()
    }
    
}
