//
//  EnemyAnimations.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 02/10/2023.
//

import UIKit

struct CharacterAnimations {
    
    static func slideFromRight(_ view: UIView, _ characterImage: UIImageView, _ hpLabel: UILabel, _ nameLabel: UILabel, _ stackView: UIStackView) {
        characterImage.frame.origin.x = view.frame.width
        characterImage.alpha = 1
        stackView.addArrangedSubview(characterImage)
        UIView.transition(with: characterImage, duration: 0.8, options: .transitionCrossDissolve, animations: {
            characterImage.frame.origin.x = view.frame.width - characterImage.frame.width
            hpLabel.alpha = 1
            nameLabel.alpha = 1
        }, completion: nil)
    }
    
    static func slideFromLeft(_ view: UIView, _ characterImage: UIImageView, _ hpLabel: UILabel, _ nameLabel: UILabel, _ stackView: UIStackView) {
        characterImage.frame.origin.x = view.frame.minX
        characterImage.alpha = 1
        stackView.insertArrangedSubview(characterImage, at: 0)
        UIView.transition(with: characterImage, duration: 0.8, options: .transitionCrossDissolve, animations: {
            characterImage.frame.origin.x = view.frame.width + characterImage.frame.width
            hpLabel.alpha = 1
            nameLabel.alpha = 1
        }, completion: nil)
    }
    
    static func slideFromBottom(_ view: UIView, _ characterImage: UIImageView, _ hpLabel: UILabel, _ nameLabel: UILabel, _ stackView: UIStackView) {
        characterImage.frame.origin.y = view.frame.height
        characterImage.alpha = 1
        stackView.addArrangedSubview(characterImage)
        UIView.transition(with: characterImage, duration: 0.8, options: .transitionCrossDissolve, animations: {
            characterImage.frame.origin.y = view.frame.height - characterImage.frame.height
            hpLabel.alpha = 1
            nameLabel.alpha = 1
        }, completion: nil)
    }
    
    static func slideFromTop(_ view: UIView, _ character: UIImageView, _ hpLabel: UILabel, _ nameLabel: UILabel, _ stackView: UIStackView) {
        character.frame.origin.y = view.frame.height
        character.alpha = 1
        stackView.addArrangedSubview(character)
        UIView.transition(with: character, duration: 0.8, options: .transitionFlipFromBottom, animations: {
            character.frame.origin.y = view.frame.height + character.frame.height
            hpLabel.alpha = 1
            nameLabel.alpha = 1
        }, completion: nil)
    }
    
    static func fadeIn(_ view: UIView, _ characterImage: UIImageView, _ hpLabel: UILabel, _ nameLabel: UILabel, _ stackView: UIStackView) {
        characterImage.frame.origin.y = view.frame.height - characterImage.frame.height
        characterImage.alpha = 1
        stackView.addArrangedSubview(characterImage)
        UIView.transition(with: characterImage, duration: 0.8, options: .transitionCrossDissolve, animations: {
            hpLabel.alpha = 1
            nameLabel.alpha = 1
        }, completion: nil)
    }
    
    static func dropDown(_ view: UIView, _ characterImage: UIImageView) {
        UIView.transition(with: characterImage, duration: 0.2, options: .transitionCrossDissolve, animations: {
            characterImage.frame.origin.y += view.frame.height
            characterImage.alpha = 0
        }, completion: nil)
        
    }
}
