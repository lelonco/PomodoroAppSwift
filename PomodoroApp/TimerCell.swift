//
//  ViewController.swift
//  PomodoroApp
//
//  Created by Yaroslav on 19.11.2020.
//
import Foundation
import UIKit
import PureLayout
class TimerCell: UICollectionViewCell {
    var isSetuped = false
    
    var layoutConstraints = [NSLayoutConstraint]()
    
    let largeHeight = 50
    let midleHeight = 40
    let regularHeight = 25
    let lineWidth = 2
    var lineSize: CGSize = .zero
    
    let lineWrapper = UIView()
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 1
        
        return view
    }()
    var index = 0
    let timeLabel:UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
//    init() {
//        super.init(frame: .zero)
//        
//        if let timeInt = time {
//            timeLabel.text = timeInt.description
//            if timeInt == 25 {
//                lineSize = CGSize(width: lineWidth, height: largeHeight)
//            } else if timeInt % 5 == 0 {
//                lineSize = CGSize(width: lineWidth, height: midleHeight)
//            } else {
//                lineSize = CGSize(width: lineWidth, height: regularHeight)
//            }
//        }
//        
//        self.index = index
//        lineWrapper.addSubview(lineView)
//        [lineWrapper,timeLabel].forEach({ self.contentView.addSubview($0) })
//
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard !isSetuped else { return }
        layoutConstraints.append(contentsOf: lineWrapper.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(), excludingEdge: .bottom))
        layoutConstraints.append(lineView.autoHCenterInSuperview())
        layoutConstraints.append(lineView.autoPinEdge(toSuperviewEdge: .bottom))
        layoutConstraints.append(contentsOf: lineView.autoSetDimensions(to: lineSize))
        
//        layoutConstraints.append(contentsOf: timeLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(), excludingEdge: .top))
        layoutConstraints.append(timeLabel.autoPinEdge(.top, to: .bottom, of: lineView))
        layoutConstraints.append(timeLabel.autoSetDimension(.height, toSize: 33))
        layoutConstraints.append(timeLabel.autoSetDimension(.width, toSize: (timeLabel.text?.getCGSize(fontHeight: 24).width ?? 24)))
        layoutConstraints.append(timeLabel.autoPinEdge(toSuperviewEdge: .bottom))
        layoutConstraints.append(timeLabel.autoHCenterInSuperview())

        isSetuped = true 
//        timeLabel.autoAlignAxis(.horizontal, toSameAxisOf: lineView)
    }
    
    func configure(index:Int, time:Int? = nil) {
  
        if let timeInt = time {
            timeLabel.text = timeInt.description
            if timeInt == 25 {
                lineSize = CGSize(width: lineWidth, height: largeHeight)
            }  else {
                lineSize = CGSize(width: lineWidth, height: midleHeight)
            }
        } else {
            lineSize = CGSize(width: lineWidth, height: regularHeight)
        }
        
        self.index = index
        lineWrapper.addSubview(lineView)
        [lineWrapper,timeLabel].forEach({ self.contentView.addSubview($0) })

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        (layoutConstraints as NSArray).autoRemoveConstraints()
        timeLabel.text = nil
//        lineWrapper.removeFromSuperview()
        [lineWrapper,timeLabel,lineView].forEach({ $0.removeFromSuperview() })
        isSetuped = false
    }
    
    
}
