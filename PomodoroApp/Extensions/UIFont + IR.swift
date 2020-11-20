//
//  UIFont + IR.swift
//  PomodoroApp
//
//  Created by Yaroslav on 20.11.2020.
//

import UIKit

enum CatamaranFontsName: String {
    case regular = "Catamaran-Regular"
//    case medium = "Catamaran-Regular.ttf"
//    case bold = "Catamaran-Regular.ttf"
    case thin = "Catamaran-Thin"
}

extension UIFont {
    
    static func catamaran(ofSize fontSize: CGFloat = 10, fontName: CatamaranFontsName = .regular) -> UIFont {
        guard let font = self.init(name: fontName.rawValue, size: fontSize) else {
            
            return .systemFont(ofSize: fontSize, weight: .medium)
        }
        return font
    }
}
