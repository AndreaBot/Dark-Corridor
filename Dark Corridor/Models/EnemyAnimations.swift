//
//  EnemyAnimations.swift
//  Dark Corridor
//
//  Created by Andrea Bottino on 02/10/2023.
//

import UIKit

struct EnemyAnimations {
    
    static func slideFromRight(_ view: UIView, _ enemyImage: UIImageView, _ enemyHP: UILabel, _ enemyNameLabel: UILabel, _ stackView: UIStackView) {
        enemyImage.frame.origin.x = view.frame.width
        enemyImage.alpha = 1
        stackView.addArrangedSubview(enemyImage)
        UIView.transition(with: enemyImage, duration: 0.8, options: .transitionCrossDissolve, animations: {
            enemyImage.frame.origin.x = view.frame.width - enemyImage.frame.width
            enemyHP.alpha = 1
            enemyNameLabel.alpha = 1
        }, completion: nil)
    }
    
    static func slideFromBottom(_ view: UIView, _ enemyImage: UIImageView, _ enemyHP: UILabel, _ enemyNameLabel: UILabel, _ stackView: UIStackView) {
        enemyImage.frame.origin.y = view.frame.height
        enemyImage.alpha = 1
        stackView.addArrangedSubview(enemyImage)
        UIView.transition(with: enemyImage, duration: 0.8, options: .transitionCrossDissolve, animations: {
            enemyImage.frame.origin.y = view.frame.height - enemyImage.frame.height
            enemyHP.alpha = 1
            enemyNameLabel.alpha = 1
        }, completion: nil)
    }
    
    static func slideFromTop(_ view: UIView, _ enemyImage: UIImageView, _ enemyHP: UILabel, _ enemyNameLabel: UILabel, _ stackView: UIStackView) {
        enemyImage.frame.origin.y = view.frame.height
        enemyImage.alpha = 1
        stackView.addArrangedSubview(enemyImage)
        UIView.transition(with: enemyImage, duration: 0.8, options: .transitionFlipFromBottom, animations: {
            enemyImage.frame.origin.y = view.frame.height + enemyImage.frame.height
            enemyHP.alpha = 1
            enemyNameLabel.alpha = 1
        }, completion: nil)
    }
    
    static func fadeIn(_ view: UIView, _ enemyImage: UIImageView, _ enemyHP: UILabel, _ enemyNameLabel: UILabel, _ stackView: UIStackView) {
        enemyImage.frame.origin.y = view.frame.height - enemyImage.frame.height
        enemyImage.alpha = 1
        stackView.addArrangedSubview(enemyImage)
        UIView.transition(with: enemyImage, duration: 0.8, options: .transitionCrossDissolve, animations: {
            enemyHP.alpha = 1
            enemyNameLabel.alpha = 1
        }, completion: nil)
    }
}
