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
        navigationController?.navigationBar.isHidden = false
        SharedCode.PList.loadItems()
        if StoreItems.allItems[2].qty! > 2 {
            Items.potion.qty = StoreItems.allItems[2].qty!
        } else {
            Items.potion.qty = 2
        }
    }
    
    @IBAction func unwindToStartViewController(_ sender: UIStoryboardSegue) {
        SharedCode.Audio.playSound("Main Menu")
    }
}
