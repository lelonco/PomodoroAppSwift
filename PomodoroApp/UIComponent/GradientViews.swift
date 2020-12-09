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
enum GradientDirection {
    case horizontal
    case verical
    case leftDiagonal
    case rightDiagonal
    
    func getStartPoint() -> CGPoint {
        switch self {
        
        case .horizontal,.verical:
            return CGPoint(x: 0, y: 0)
        case  .rightDiagonal :
            return CGPoint(x: 1, y: 0)
        case .leftDiagonal:
            return CGPoint(x: 0, y: 1)

        }
    }
    func getEndPoint() -> CGPoint {
        switch self {

        case .horizontal:
            return CGPoint(x: 1, y: 0)
        case .verical:
            return CGPoint(x: 0, y: 1)
        case .leftDiagonal:
            return CGPoint(x: 1, y:0)
        case .rightDiagonal:
            return CGPoint(x: 0, y: 1)


        }
    }
}
class GradientView: UIView {

    var startColor = UIColor(rgbHex:0x91C4E1).cgColor
    var endColor = UIColor(rgbHex:0x7056B3).cgColor
    var gradientDierction: GradientDirection = .horizontal
    override var bounds: CGRect {
        didSet {
            updateMask()
        }
    }

    init(startColor:UIColor, endColor:UIColor, gradientDirectrion:GradientDirection) {
        super.init(frame: .zero)
        self.startColor = startColor.cgColor
        self.endColor = endColor.cgColor
        self.gradientDierction = gradientDirectrion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateMask() {
        let gradient = CAGradientLayer()

        gradient.colors = [startColor, endColor]
        gradient.endPoint = self.gradientDierction.getEndPoint()
        gradient.startPoint = self.gradientDierction.getStartPoint()
        gradient.frame = CGRect(x: 0.0,
                                y: 0.0,
                                width: self.frame.size.width,
                                height: self.frame.size.height)
        if let gradientLayer = self.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.removeFromSuperlayer()
        }
        gradient.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gradient, at: 0)
    }
}
