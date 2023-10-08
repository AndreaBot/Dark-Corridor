//
//  ViewController.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 26/03/2023.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet var path: [UIImageView]!
    @IBOutlet weak var exitTile: UIImageView!
    
    
    var character1 = Character()
    var items = Items()
    
    var updatedHealth = 20
    
    var tagLeft = 0
    var tagRight = 0
    
    var playerBack = ""
    var playerLeft = ""
    var playerRight = ""
    var colorExit = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        exitButton.isEnabled = false
        
        for image in path {
            image.image = UIImage(named: "BlackTileNew")
        }
        path[Character.up].image = UIImage(named: playerBack)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        SharedCode.Audio.playSound("Main Game")
        view.backgroundColor = .black
        messageLabel.text = ""
        messageLabel.textColor = .white
    }
    
    @IBAction func moveUp(_ sender: UIButton) {
        if Character.up + 1 < 10 {
            character1.moveUp()
            
            for image in path {
                image.image = UIImage(named: "BlackTileNew")
            }
            path[Character.up].image = UIImage(named: playerBack)
            leftButton.isEnabled = true
            rightButton.isEnabled = true
            tagLeft = 0
            tagRight = 0
        } else {
            for image in path {
                image.image = UIImage(named: "BlackTileNew")
            }
            exitTile.image = UIImage(named: colorExit)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
                self.performSegue(withIdentifier: "goToResult", sender: self)
                messageLabel.text = ""
                exitButton.isEnabled = false
                upButton.isEnabled = false
                leftButton.isEnabled = false
                rightButton.isEnabled = false
            }
        }
    }
    
    
    @IBAction func roomEntered(_ sender: UIButton) {

        if sender.currentImage == UIImage(systemName: "arrowtriangle.backward") {
            path[Character.up].image = UIImage(named: playerLeft)
            tagLeft = 1
            
        } else if sender.currentImage == UIImage(systemName: "arrowtriangle.forward") {
            path[Character.up].image = UIImage(named: playerRight)
            tagRight = 2
            
        }
        leftButton.isEnabled = false
        rightButton.isEnabled = false
        upButton.isEnabled = false
        exitButton.isEnabled = true
        
        func randomFound() {
//            let randomRoom = ["item", "enemy", "empty"]
            let randomRoom = ["item"]
            let randomResult = randomRoom.randomElement()
            
            if randomResult == "item" {
                items.itemFound()
                messageLabel.text = Items.foundText
                
            } else if randomResult == "enemy" {
                messageLabel.text = "An enemy attacks you!"
                SharedCode.Audio.playSound("Enemy Found")
                view.backgroundColor = .red
                messageLabel.textColor = .black
                exitButton.isEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) { [self] in
                    self.performSegue(withIdentifier: "goToBattle", sender: self)
                }
            } else {
                messageLabel.text = "Nothing to see here..."
            }
        }
        randomFound()
    }
    
    @IBAction func exitRoom(_ sender: UIButton) {
        
        messageLabel.text = ""
        upButton.isEnabled = true
        path[Character.up].image = UIImage(named: playerBack)
        
        if tagLeft == 1 && tagRight == 0 {
            rightButton.isEnabled = true
        } else if tagRight == 2 && tagLeft == 0{
            leftButton.isEnabled = true
        }
        
        exitButton.isEnabled = false

    }
    
    @IBAction func unwindToPreviousViewController(_ sender: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.song = "Win Screen"
            destinationVC.message = "SUCCESS! \nYou've escaped the Dark Corridor!"
    
        } else if segue.identifier == "goToBattle" {
            let destinationVC = segue.destination as! BattleViewController
            if playerBack == "RedHeroBack" {
                destinationVC.battleImage = "RedHeroBackBig"
            } else if playerBack == "BlueHeroBack" {
                destinationVC.battleImage = "BlueHeroBackBig"
            }  else if playerBack == "GreenHeroBack" {
                destinationVC.battleImage = "GreenHeroBackBig"
            }  else if playerBack == "DarkHeroBack" {
                destinationVC.battleImage = "DarkHeroBackBig"
            }
        }
    }
}


