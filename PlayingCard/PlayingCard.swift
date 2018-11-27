//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by corrci on 2018/11/28.
//  Copyright © 2018 corrci. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible {
    var description: String{ return "\(suit)\(rank)" }
    
    var suit: Suit
    var rank: Rank
    
    enum Suit: String, CaseIterable, CustomStringConvertible {
        var description: String { return rawValue}
        
        case spades = "♠️"
        case hearts = "♥️"
        case clubs = "♣️"
        case diamonds = "♦️"
    }
    enum Rank: CustomStringConvertible {
        var description: String {
            switch self {
            case .ace: return "A"
            case .face(let kind): return kind
            case .numeric(let pips): return String(pips)
            }
        }
        
        case ace
        case face(String)
        case numeric(Int)
        
        //creat pokers's number
        var order: Int{
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default:
                return 0
            }
        }
        
        //13 poker
        static var all: [Rank]{
            var allRanks = [Rank.ace]
            for pips in 2...10{
                allRanks.append(Rank.numeric(pips))
            }
            allRanks += [Rank.face("J"), .face("Q"), .face("K")]
            return allRanks
        }
    }
}
