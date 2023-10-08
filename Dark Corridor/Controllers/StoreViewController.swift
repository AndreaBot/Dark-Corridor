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
    
    @IBAction func exitButton(_ sender: UIButton) {
        dismiss(animated: true)
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
    
    func showAlert(_ title: String) {
        let alert = UIAlertController(title: title, message: findExplanationText(title), preferredStyle: .alert)
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
            self.showAlert("Warning")
        }
    }
    
    func confirmPurchase(_ item: String, _ price: Int) {
        
//        do {
//            try self.realm.write {
//                pointsAmount -= price
//            }
//        } catch {
//            print(error)
//        }
        
        pointsAmount -= price

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
        
        SharedCode.PList.saveItems()
        storeTableView.reloadData()
    }
    
    func findExplanationText(_ title: String) -> String {
        
        switch title {
        case "Potion": return StoreItems.allItems[2].explanation!;
        case "Power Up": return StoreItems.allItems[3].explanation!;
        case "Second Chance": return StoreItems.allItems[4].explanation!;
        case "Warning": return "You do not have enough points to buy this item."
        default: return "Item not found"
        }
    }
}
