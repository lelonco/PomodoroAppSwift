//
//  BackgroundGradient.swift
//  PomodoroApp
//
//  Created by Yaroslav on 20.11.2020.
//

import UIKit

class BackgroundGradient: UIView {
    var startColor = UIColor(rgbHex:0x91C4E1).cgColor
    var endColor = UIColor(rgbHex:0x7056B3).cgColor

    override var bounds: CGRect {
        didSet {
            updateMask()
        }
    }

    private func updateMask() {
        let gradient = CAGradientLayer()

        gradient.colors = [startColor, endColor]
        gradient.endPoint = CGPoint(x: 0, y: 0)
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.frame = CGRect(x: 0.0,
                                y: 0.0,
                                width: self.frame.size.width,
                                height: self.frame.size.height)

        self.layer.insertSublayer(gradient, at: 0)
    }
}
