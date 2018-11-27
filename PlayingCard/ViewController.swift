//
//  ViewController.swift
//  PlayingCard
//
//  Created by corrci on 2018/11/28.
//  Copyright © 2018 corrci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var deck = PlayingCardDeck()

    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10{
            if let card = deck.draw(){
                print("\(card)")
            }
        }
    }


}

