//
//  InventoryCell.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 16/09/2023.
//

import UIKit

class InventoryCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemName.textColor = .white
        itemQuantity.textColor = .white
        contentView.backgroundColor = .black
    }
}
