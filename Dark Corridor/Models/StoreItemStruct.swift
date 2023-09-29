//
//  StoreItemStruct.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 25/09/2023.
//

import Foundation

struct StoreItemStruct : Codable {
    
    var itemImageName: String
    var itemName: String
    var price: Int
    var isPurchased: Bool
}
