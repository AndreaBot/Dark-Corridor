//
//  StatsViewController.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 18/09/2023.
//

import UIKit
import RealmSwift

class StatsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var allStats: Results<StatClass>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.register(UINib(nibName: "InventoryCell", bundle: nil), forCellReuseIdentifier: "inventoryCell")
        
        allStats = realm.objects(StatClass.self)
    }
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

// MARK: - Table view data source

extension StatsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let playerStats = allStats {
            return playerStats.isEmpty ? 1 : playerStats.count
        } else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "inventoryCell", for: indexPath) as! InventoryCell
        
        if let playerStats = allStats {
            if playerStats.count == 0 {
                cell.itemName.text = "👻 Oops! Nothing to see here, yet. Start playing to see your stats!"
                cell.itemName.numberOfLines = 2
                cell.itemName.adjustsFontSizeToFitWidth = true
                cell.itemName.textAlignment = .center
                cell.itemQuantity.isHidden = true
                cell.itemImage.isHidden = true
            } else {
                let stat = playerStats[indexPath.row]
                
                cell.stackView.distribution = .fillProportionally
                cell.itemName.textAlignment = .left
                cell.itemQuantity.textAlignment = .right
                
                cell.itemName.text = stat.name
                cell.itemQuantity.text = String(stat.value)
            }
        }
        return cell
    }

}


