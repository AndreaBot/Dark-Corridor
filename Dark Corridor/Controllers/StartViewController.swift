//
//  StartViewController.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 04/04/2023.
//

import UIKit
import AVFoundation

class StartViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedCode.Audio.playSound("Main Menu")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        SharedCode.PList.loadItems()
        Items.potion.qty = StoreItems.allItems[2].qty!
    }
}

