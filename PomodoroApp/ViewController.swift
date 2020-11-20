//
//  ViewController.swift
//  PomodoroApp
//
//  Created by Yaroslav on 19.11.2020.
//

import UIKit
import PureLayout

class ViewController: UIViewController {
    
    let sideEdgeInset: CGFloat = 34
    
    let gradientColors = [UIColor(rgbHex:0x7056B3).cgColor, UIColor(rgbHex:0x91C4E1).cgColor]
    var lastScrolledIndex: IndexPath = IndexPath(item: 0, section: 0) {
        didSet {
            timerLabel.text = "\(lastScrolledIndex.item):00"
        }
    }
    var isLayouted = false
    var reuseIdentifier = "timerCollectionViewCell"
    
    let timerCollectionView: UICollectionView = {
        let flowLayot = FadingLayout(scrollDirection: .horizontal)

        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayot)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.contentMode = .scaleToFill
        collection.allowsMultipleSelection = false
        collection.bounces = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    let timerLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .catamaran(ofSize: 100, fontName: .thin)
        label.text = "25:00"
        
        return label
    }()
    
    let categoryTitleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .catamaran(ofSize: 18)
        label.text = "Freestyle"
        label.alpha = 0.7
        return label
    }()
    
    let backgroundGradient = BackgroundGradient()
    init() {
        super.init(nibName: nil, bundle: nil)
        timerCollectionView.dataSource = self
        timerCollectionView.delegate = self //TODO: Did i need it?
        timerCollectionView.register(TimerCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        [backgroundGradient,categoryTitleLabel,timerLabel,timerCollectionView].forEach({ self.view.addSubview($0) })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setNeedsUpdateConstraints()
        let inset = self.view.center.x - (1 + sideEdgeInset)    // 1 – is half of the cell width
        timerCollectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)

        // Do any additional setup after loading the view.
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        guard !isLayouted else { return }
        backgroundGradient.autoPinEdgesToSuperviewEdges()
        categoryTitleLabel.autoPinEdge(toSuperviewEdge: .top,withInset: 47)
        categoryTitleLabel.autoHCenterInSuperview()
        
        timerLabel.autoPinEdge(.top, to: .bottom, of: categoryTitleLabel, withOffset: 5)
        timerLabel.autoHCenterInSuperview()

        
        timerCollectionView.autoPinEdge(.top, to: .bottom, of: timerLabel, withOffset: 25)
        timerCollectionView.autoPinEdge(toSuperviewEdge: .leading, withInset: sideEdgeInset)
        timerCollectionView.autoPinEdge(toSuperviewEdge: .trailing, withInset: sideEdgeInset)
        timerCollectionView.autoSetDimension(.height, toSize: 84)

        isLayouted = true
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    
}

extension ViewController: UIScrollViewDelegate {
//TODO: Fix force stop of scrolling
//TODO: Need to try recreate mechanism of updating selected cell based on lastApearedCell and lastDisapearedCell
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        if let index = self.timerCollectionView.indexPathForItem(at:self.timerCollectionView.convert(self.timerCollectionView.center, from: self.view)) {
            self.timerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            timerLabel.text = "\(index.item):00"
        } else {
            self.timerCollectionView.scrollToItem(at: lastScrolledIndex, at: .centeredHorizontally, animated: true)
            timerLabel.text = "\(lastScrolledIndex.item):00"
            return
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let index = self.timerCollectionView.indexPathForItem(at: self.timerCollectionView.convert(self.timerCollectionView.center , from: self.view)) else {
            return
        }
        lastScrolledIndex = index
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 51
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? TimerCell else {
            assertionFailure("Cant cast cell")
            return UICollectionViewCell()
        }
        
        cell.configure(index: index, time: index % 5 == 0 ? index : nil)
        return cell
    }
    
    
}
