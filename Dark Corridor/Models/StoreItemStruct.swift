//
//  StoreItemStruct.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 25/09/2023.
//

import Foundation

struct StoreItemStruct: Codable {
    
    let itemImageName: String
    let itemName: String
    let price: Int
    var isPurchased: Bool
    let needsExplaining: Bool
    let explanation: String?
}
