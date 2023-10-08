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
    let categoryOrder = ["General", "Loot", "Enemies"]
    
    var sections: [String: [StatClass]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.backgroundColor = .black
        
        tableView.register(UINib(nibName: "InventoryCell", bundle: nil), forCellReuseIdentifier: "inventoryCell")
        
        allStats = realm.objects(StatClass.self)
        
        for category in categoryOrder {
            sections[category] = []
        }
        
        for stat in allStats! {
            if var categoryStats = sections[stat.category] {
                categoryStats.append(stat)
                sections[stat.category] = categoryStats
            }
        }
    }
}

// MARK: - Table view data source

extension StatsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allStats!.count > 0 ? categoryOrder.count : 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = categoryOrder[section]
        return allStats!.count > 0 ? sections[category]!.count : 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if allStats!.count > 0 {
            let headerView = UIView()
            headerView.backgroundColor = .black
            
            let titleLabel = UILabel()
            titleLabel.text = categoryOrder[section]
            titleLabel.font = UIFont.systemFont(ofSize: 20)
            titleLabel.textColor = .link
            titleLabel.frame = CGRect(x: 16, y: -10, width: tableView.frame.size.width - 32, height: 50)
            
            let separatorView = UIView()
            separatorView.backgroundColor = .link
            separatorView.frame = CGRect(x: 0, y: 30, width: tableView.frame.size.width, height: 1)
            
            headerView.addSubview(titleLabel)
            headerView.addSubview(separatorView)
            
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inventoryCell", for: indexPath) as! InventoryCell
        
        if allStats!.count > 0 {
            let category = categoryOrder[indexPath.section]
            let stat = sections[category]![indexPath.row]
            cell.stackView.distribution = .fillProportionally
            cell.itemName.textAlignment = .left
            cell.itemQuantity.textAlignment = .right
            
            cell.itemName.text = stat.name
            cell.itemQuantity.text = String(stat.value)
            
        } else {
            cell.itemName.text = "👻 Oops! Nothing to see here, yet. Start playing to see your stats!"
            cell.itemName.numberOfLines = 2
            cell.itemName.adjustsFontSizeToFitWidth = true
            cell.itemName.textAlignment = .center
            cell.itemQuantity.isHidden = true
            cell.itemImage.isHidden = true
        }
        return cell
    }
}


