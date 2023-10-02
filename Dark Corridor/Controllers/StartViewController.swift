//
//  StartViewController.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 04/04/2023.
//

import UIKit
import AVFoundation

class StartViewController: UIViewController {

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: "StoreItems.plist")
    var music: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadItems()
        Items.potion.qty = StoreItems.allItems[2].qty!
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "goToStory", sender: self)
    }
    
    @IBAction func unwindToStartViewController(_ sender: UIStoryboardSegue) {
        playSound()
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "Main Menu", withExtension: "mp3")
        music = try! AVAudioPlayer(contentsOf: url!)
        music.play()
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                StoreItems.allItems = try decoder.decode([StoreItemStruct].self, from: data)
            } catch {
                print("error decoding item array, \(error)")
            }
        } else {
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToStory" {
            let destinationVC = segue.destination as! SettingsViewController
            destinationVC.music = music
        }
    }
}

