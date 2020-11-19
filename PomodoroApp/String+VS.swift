//
//  ViewController.swift
//  PomodoroApp
//
//  Created by Yaroslav on 19.11.2020.
//

import UIKit
import Foundation

extension String {
    
    /**
        Get CGSize of Gotham font
     */
    func getCGSize(fontHeight: CGFloat) -> CGSize {
        
        return getCGSize(font: .systemFont(ofSize: fontHeight))
    }
    
    func getCGSize(name fontName: String, fontHeight: CGFloat) -> CGSize {
        guard let font = UIFont.init(name: fontName, size: fontHeight) else {
            return getCGSize(fontHeight: fontHeight)
        }
        return getCGSize(font: font)
    }
    
    func getCGSize(font: UIFont, fontHeight: CGFloat? = nil) -> CGSize {
        let mesureFont = font.withSize(fontHeight ?? font.lineHeight)
        let fontAttributes = [NSAttributedString.Key.font: mesureFont]
        return (self as NSString).size(withAttributes: fontAttributes)
    }
    
    /**
        Get CGSize of Gotham font with constraint rect 
     */
    func getCGSize(fontHeight: CGFloat, rect: CGSize) -> CGSize {
        
        let mesureFont = UIFont.systemFont(ofSize: fontHeight)
        let fontAttributes = [NSAttributedString.Key.font: mesureFont]
        let attributedText = NSAttributedString(string: self, attributes: fontAttributes)

        return attributedText.boundingRect(with: rect, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).size
    }
}
