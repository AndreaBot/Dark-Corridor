//
//  StoreCell.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 25/09/2023.
//

import UIKit

protocol StoreCellDelegate {
    func processPurchase(_ item: String, _ price: Int)
    func showAlert(_ title: String, _ message: String)
}

class StoreCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var explanationButton: UIButton!
    
    static var delegate: StoreCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemImage.backgroundColor = .clear
        itemNameLabel.backgroundColor = .clear
        itemPriceLabel.backgroundColor = .clear
        
        itemNameLabel.textColor = .white
        itemPriceLabel.textColor = .white
    }
    
    @IBAction func buyButtonPressed(_ sender: UIButton) {
        
        let selectedItem = itemNameLabel.text!
        let price = Int(itemPriceLabel.text!)!
        StoreCell.delegate?.processPurchase(selectedItem, price)
    }

    
    @IBAction func explain(_ sender: UIButton) {
        StoreCell.delegate?.showAlert("Power Up", "Increase your attacks damage by 3 points. \nYou can only buy one of these per game")
    }
}
