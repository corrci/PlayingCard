//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by corrci on 2018/11/29.
//  Copyright © 2018 corrci. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {

    private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString{
        //creat font and fontSize
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        //change fontSize by iphone
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        //make the font center
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        //return
        return NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle, .font: font])
    }
    
    //creat rect and cornerRadius
    override func draw(_ rect: CGRect) {
        let roundRect = UIBezierPath(roundedRect: bounds, cornerRadius: 18.0)
        roundRect.addClip()
        UIColor.white.setFill()
        roundRect.fill()
    }
}
