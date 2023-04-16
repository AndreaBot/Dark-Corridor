//
//  CustomCell.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 08/04/2023.
//

import UIKit

class CustomCell: UITableViewCell {
    let itemNameLabel = UILabel()
    let quantityLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add itemNameLabel to the cell's content view and set its constraints
        contentView.addSubview(itemNameLabel)
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        itemNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        // Add quantityLabel to the cell's content view and set its constraints
        contentView.addSubview(quantityLabel)
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        quantityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
