//
//  StartPauseButton.swift
//  PomodoroApp
//
//  Created by Yaroslav on 24.11.2020.
//

import UIKit

class StartPauseButton: UIButton {
    var didTimerStarted = false {
        didSet {
            let imageName = didTimerStarted ? "pauseIcon" : "playIcon"
        
            iconImageView.image = UIImage(named: imageName)
        }
    }
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "playIcon"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [iconImageView].forEach({ self.addSubview($0) })
        iconImageView.autoPinEdgesToSuperviewEdges()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

