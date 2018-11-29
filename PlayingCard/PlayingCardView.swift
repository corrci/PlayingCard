//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by corrci on 2018/11/29.
//  Copyright © 2018 corrci. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {
    
    var rank: Int = 5 {didSet{ setNeedsDisplay(); setNeedsLayout()}}
    var suit: String = "♥️" {didSet{ setNeedsDisplay(); setNeedsLayout()}}
    var isFaceUp: Bool = true {didSet{ setNeedsDisplay(); setNeedsLayout()}}
    
    //creat rect and cornerRadius
    override func draw(_ rect: CGRect) {
        let roundRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundRect.addClip()
        UIColor.white.setFill()
        roundRect.fill()
    }

    private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString{
        //create font and fontSize
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        //change fontSize by iphone
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        //make the font center
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        //return
        return NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle, .font: font])
    }
    
    //create cornerString
    private var cornerString: NSAttributedString{
        return centeredAttributedString(rankString+"\n"+suit, fontSize: cornerFontSize)
    }
    
    //create cornerStringLabel
    private lazy var upperLeftCornerLabel = createCornerLabel()
    private lazy var lowRightCornerLabel = createCornerLabel()
    private func createCornerLabel() -> UILabel{
        let label = UILabel()
        //0 can take more lines
        label.numberOfLines = 0
        addSubview(label)
        return label
    }
    
    //put cornerString in label
    private func configureCornerLabel(_ label: UILabel){
        label.attributedText = cornerString
        //clean the size it can fill all label
        label.frame.size = CGSize.zero
        label.sizeToFit()
        label.isHidden = !isFaceUp
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //frame is the location
        configureCornerLabel(upperLeftCornerLabel)
        upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
        
        configureCornerLabel(lowRightCornerLabel)
        //transform lowRightCornerLabel
        lowRightCornerLabel.transform = CGAffineTransform.identity
            .translatedBy(x: lowRightCornerLabel.frame.width, y: lowRightCornerLabel.frame.height)
            .rotated(by: CGFloat.pi)
        lowRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
            .offsetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offsetBy(dx: -lowRightCornerLabel.frame.width, dy: -lowRightCornerLabel.frame.height)
    }
    
    //font change have to call this, like font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    

}


extension PlayingCardView {
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    private var rankString: String {
        switch rank {
        case 1: return "A"
        case 2...10: return String(rank)
        case 11: return "J"
        case 12: return "Q"
        case 13: return "K"
        default: return "?"
        }
    }
}

extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
