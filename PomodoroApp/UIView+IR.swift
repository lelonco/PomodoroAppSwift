//
//  ViewController.swift
//  PomodoroApp
//
//  Created by Yaroslav on 19.11.2020.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult
    func autoHCenterInSuperview() -> NSLayoutConstraint {
        return autoAlignAxis(.vertical, toSameAxisOf: self.superview!)
    }
    
    @discardableResult
    func autoVCenterInSuperview() -> NSLayoutConstraint {
        return autoAlignAxis(.horizontal, toSameAxisOf: self.superview!)
    }
}
