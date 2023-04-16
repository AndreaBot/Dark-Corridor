//
//  ResultViewController.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 04/04/2023.
//

import UIKit
import AVFoundation

class ResultViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var finalSoulQtyLabel: UILabel!
    @IBOutlet weak var finalDiamondQtyLabel: UILabel!
    @IBOutlet weak var finalGoldQtyLabel: UILabel!
    @IBOutlet weak var finalDirtQtyLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var items = Items()
    
    var message = ""
    
    var finalSoulQty = 0
    var finalDiamondQty = 0
    var finalGoldQty = 0
    var finalDirtQty = 0
    
    var totSoulPts = 0
    var totDiamondPts = 0
    var totGoldPts = 0
    var totDirtPts = 0
    
    var music: AVAudioPlayer!
    var song = ""
    

    override func viewDidLoad() {
        playSound(soundName: song)
        super.viewDidLoad()
        messageLabel.text = message
        
        totSoulPts = finalSoulQty * items.allItems[0].value
        finalSoulQtyLabel.text = "\(finalSoulQty) x \(items.allItems[0].value) = \(totSoulPts)"
        
        totDiamondPts = finalDiamondQty * items.allItems[1].value
        finalDiamondQtyLabel.text = "\(finalDiamondQty) x \(items.allItems[1].value) = \(totDiamondPts)"
        
        totGoldPts = finalGoldQty * items.allItems[2].value
        finalGoldQtyLabel.text = "\(finalGoldQty) x \(items.allItems[2].value) = \(totGoldPts)"
        
        totDirtPts = finalDirtQty * items.allItems[3].value
        finalDirtQtyLabel.text = "\(finalDirtQty) x \(items.allItems[3].value) = \(totDirtPts)"
        
        
        
        let result = totSoulPts + totDiamondPts + totGoldPts + totDirtPts
        
        resultLabel.text = String(result)
        resultLabel.layer.borderColor = CGColor(gray: 1, alpha: 1)
        resultLabel.layer.borderWidth = 4
        resultLabel.layer.cornerRadius = 50
    
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        music = try! AVAudioPlayer(contentsOf: url!)
        music.play()
    }
}
