//
//  StoreCell.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 25/09/2023.
//

import UIKit

protocol StoreCellDelegate {
    func processPurchase(_ item: String, _ price: Int)
    func showExplanationAlert(_ title: String)
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
        
        purchaseButton.layer.cornerRadius = purchaseButton.frame.height/2
        purchaseButton.layer.borderWidth = 2
    }
    
    @IBAction func buyButtonPressed(_ sender: UIButton) {
        
        let selectedItem = itemNameLabel.text!
        let price = Int(itemPriceLabel.text!)!
        StoreCell.delegate?.processPurchase(selectedItem, price)
    }
    
    
    @IBAction func explain(_ sender: UIButton) {
        
        let selectedItem = itemNameLabel.text!
        StoreCell.delegate?.showExplanationAlert(selectedItem)
    }
}
