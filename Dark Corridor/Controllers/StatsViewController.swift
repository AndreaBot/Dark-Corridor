//
//  StatsViewController.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 18/09/2023.
//

import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let defaults = UserDefaults.standard
    var playerStatsArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 60
        
        tableView.register(UINib(nibName: "InventoryCell", bundle: nil), forCellReuseIdentifier: "inventoryCell")
        if let playerStats = defaults.object(forKey: "playerStats") as? [String : Int] {
            PlayerStats.overallStats = playerStats
            playerStatsArray = Array(playerStats.keys)
        }
    }
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
    
    // MARK: - Table view data source
    
    extension StatsViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if playerStatsArray == [] {
                return 1
            } else {
                return playerStatsArray.count
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "inventoryCell", for: indexPath) as! InventoryCell
            
            if playerStatsArray == [] {
                cell.itemName.text = "👻 Oops! Nothing to see here, yet. Start playing to see your stats!"
                cell.itemName.numberOfLines = 2
                cell.itemName.adjustsFontSizeToFitWidth = true
                cell.itemName.textAlignment = .center
                cell.itemQuantity.isHidden = true
                cell.itemImage.isHidden = true
            } else {
                let stat = playerStatsArray[indexPath.row]
                
                cell.stackView.distribution = .fillProportionally
                cell.itemName.textAlignment = .left
                cell.itemQuantity.textAlignment = .right
                
                cell.itemName.text = stat
                cell.itemQuantity.text = String(PlayerStats.overallStats[stat]!)
            }
            return cell
        }
    }



