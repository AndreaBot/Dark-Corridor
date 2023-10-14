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
    var realmStats: Results<StatClass>? {
        didSet {
            if realmStats!.count > 1 {
                pointsAmount = realmStats![0].value
            } else {
                pointsAmount = 0
            }
        }
    }
    
    var pointsAmount: Int = 0 {
        didSet {
            pointsLabel.text = "🟡 " + String(pointsAmount)
            PlayerStats.points.value = pointsAmount
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Store"
        SharedCode.PList.loadItems()
        
        do {
            try self.realm.write {
                realmStats = realm.objects(StatClass.self)
                if realmStats!.count > 1 {
                    pointsAmount = realmStats![0].value
                } else {
                    pointsAmount = 0
                }
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
            if let stats = realmStats, stats.count > 1 {
                let points = stats[0]
                try self.realm.write {
                    points.value = pointsAmount
                }
            } else {
                return
            }
        } catch {
            print("Error: \(error)")
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
        cell.explanationButton.alpha = item.needsExplaining ? 1 : 0

        if item.isPurchased {
            cell.purchaseButton.isUserInteractionEnabled = false
            cell.purchaseButton.setImage(UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysOriginal), for: .normal)
            cell.purchaseButton.setTitle("", for: .normal)
            cell.purchaseButton.layer.borderColor = CGColor(gray: 5, alpha: 0)
        } else {
            cell.purchaseButton.isUserInteractionEnabled = true
            cell.purchaseButton.setTitle("BUY", for: .normal)
            cell.purchaseButton.setImage(nil, for: .normal)
            cell.purchaseButton.layer.borderColor = CGColor(red: 0, green: 0.3, blue: 1, alpha: 1)
        }

        cell.backgroundColor = .clear
        
        return cell
    }
}

extension StoreViewController: StoreCellDelegate {
    
    func showExplanationAlert(_ title: String) {
        present(SharedCode.Alerts.showOkAlert(title, StoreItems.findExplanationText(title)), animated: true)
    }
    
    func processPurchase(_ item: String, _ price: Int) {
        
        if self.pointsAmount >= price {
            present(SharedCode.Alerts.purchaseAlert(item, price, { itemName, itemPrice in
                self.confirmPurchase(itemName, itemPrice)
            }), animated: true)
        } else {
            present(SharedCode.Alerts.showOkAlert("Warning", "You do not have enough points to buy this item."), animated: true)
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
        case "Power Up": buyPowerUp();
        case "Second Chance": buySecondChance()
        default:
            print("item not found")
        }
        
        func buyGreenHero() {
            StoreItems.allItems[0].isPurchased = true
        }
        
        func buyDarkHero() {
           StoreItems.allItems[1].isPurchased = true
        }
        
        func buyPotion() {
            Items.potion.qty += 1
            StoreItems.allItems[2].qty! = Items.potion.qty
        }
        
        func buyPowerUp() {
            StoreItems.allItems[3].isPurchased = true
            Character.attack1.damage += 3; Character.attack2.damage += 3
        }
        
        func buySecondChance() {
            StoreItems.allItems[4].isPurchased = true
        }
        
        SharedCode.animateText(pointsLabel, .red)
        SharedCode.PList.saveItems()
        storeTableView.reloadData()
    }
}
