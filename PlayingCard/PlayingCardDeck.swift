//
//  PlayingCardDeck.swift
//  PlayingCard
//
//  Created by corrci on 2018/11/28.
//  Copyright © 2018 corrci. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
    private(set) var cards = [PlayingCard]()
    
    init() {
        for suit in PlayingCard.Suit.allCases{
            for rank in PlayingCard.Rank.all{
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }
    
    mutating func draw() -> PlayingCard?{
        if cards.count > 0{
            return cards.remove(at: Int.random(in: 0..<cards.count))
        }else{
            return nil
        }
    }
}
