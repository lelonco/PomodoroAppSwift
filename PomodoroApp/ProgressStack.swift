//
//  StartPauseButton.swift
//  PomodoroApp
//
//  Created by Yaroslav on 23.11.2020.
//

import UIKit

class ProgressStack: UIView {
    var buttonAction: (() -> ())? = nil
    
    let roundLabel: UILabel = {
        
        let label = UILabel()
        let str = "Round 0/4"
        let startIndex = 0
        let lastWordLen = str.distance(from: str.firstIndex(of: " ") ?? str.startIndex, to: str.endIndex)
        let indexOfSpace = str.distance(from: str.startIndex, to: str.firstIndex(of: " ") ?? str.startIndex )
        let attributedString = NSMutableAttributedString(string: str)
        
        attributedString.addAttribute(.kern, value: 10, range: NSRange(location: indexOfSpace,length: 1 ))
        attributedString.addAttribute(.font, value: UIFont.catamaran(ofSize: 14, fontName: .thin), range: NSRange(location: 0, length: indexOfSpace))
        attributedString.addAttribute(.font, value: UIFont.catamaran(ofSize: 14, fontName: .bold), range: NSRange(location: indexOfSpace + 1, length: lastWordLen - 1))
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: str.count))
        
        label.attributedText = attributedString
        return label

    }()
    let roundLabelWrapper = UIView()
    let goalLabel: UILabel = {

        let label = UILabel()
        let str = "0/12 Goal"
        let startIndex = 0
        let lastWordLen = str.distance(from: str.firstIndex(of: " ") ?? str.startIndex, to: str.endIndex)
        let indexOfSpace = str.distance(from: str.startIndex, to: str.firstIndex(of: " ") ?? str.startIndex )
        let attributedString = NSMutableAttributedString(string: str)
        
        attributedString.addAttribute(.kern, value: 10, range: NSRange(location: indexOfSpace,length: 1 ))
        attributedString.addAttribute(.font, value: UIFont.catamaran(ofSize: 14, fontName: .bold), range: NSRange(location: 0, length: indexOfSpace))
        attributedString.addAttribute(.font, value: UIFont.catamaran(ofSize: 14, fontName: .thin), range: NSRange(location: indexOfSpace + 1, length: lastWordLen - 1))
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: str.count))
        
        label.attributedText = attributedString
        return label
    }()
    let goalLabelWrapper = UIView()
    let startPauseButton = StartPauseButton()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 10
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stack)

        [roundLabel,startPauseButton,goalLabel].forEach({ self.stack.addArrangedSubview($0) })
        startPauseButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        stack.autoPinEdgesToSuperviewEdges()
    }
    
    @objc
    func buttonTapped() {
        startPauseButton.didTimerStarted.toggle()
        buttonAction?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateGoal(text: String) {
        guard let indexOfSpace = text.firstIndex(of: " ") else { return }
        let lastWordLen = text.distance(from: indexOfSpace, to: text.endIndex)
        let intIndexOfSpace = text.distance(from: text.startIndex, to: indexOfSpace)
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.addAttribute(.kern, value: 10, range: NSRange(location: intIndexOfSpace,length: 1 ))
        attributedString.addAttribute(.font, value: UIFont.catamaran(ofSize: 14, fontName: .bold), range: NSRange(location: 0, length: intIndexOfSpace))
        attributedString.addAttribute(.font, value: UIFont.catamaran(ofSize: 14, fontName: .thin), range: NSRange(location: intIndexOfSpace + 1, length: lastWordLen - 1))
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: text.count))
        goalLabel.attributedText = attributedString
    }
    
    func updateRound(text: String) {
        guard let indexOfSpace = text.firstIndex(of: " ") else { return }
        let lastWordLen = text.distance(from: indexOfSpace, to: text.endIndex)
        let intIndexOfSpace = text.distance(from: text.startIndex, to: indexOfSpace)
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.addAttribute(.kern, value: 10, range: NSRange(location: intIndexOfSpace,length: 1 ))
        attributedString.addAttribute(.font, value: UIFont.catamaran(ofSize: 14, fontName: .thin), range: NSRange(location: 0, length: intIndexOfSpace))
        attributedString.addAttribute(.font, value: UIFont.catamaran(ofSize: 14, fontName: .bold), range: NSRange(location: intIndexOfSpace + 1, length: lastWordLen - 1))
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: text.count))
        
        roundLabel.attributedText = attributedString
    }
}
