//
//  UIColor+IR.swift
//  PomodoroApp
//
//  Created by Yaroslav on 20.11.2020.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(rgbHex value: UInt) {
        let red = CGFloat(((value >> 16) & 0xff)) / 255.0
        let green = CGFloat(((value >> 8) & 0xff)) / 255.0
        let blue = CGFloat(((value >> 0) & 0xff)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}


