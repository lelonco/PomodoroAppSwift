//
//  ViewController.swift
//  PomodoroApp
//
//  Created by Yaroslav on 19.11.2020.
//

import UIKit
import PureLayout

class ViewController: UIViewController {
    
    var lastScrolledIndex: IndexPath = IndexPath(item: 0, section: 0)
    var isLayouted = false
    var reuseIdentifier = "timerCollectionViewCell"
    
    let collectionView: UICollectionView = {
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
    
    init() {
        super.init(nibName: nil, bundle: nil)
        collectionView.dataSource = self
        collectionView.delegate = self //TODO: Did i need it?
        collectionView.register(TimerCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.view.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(collectionView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setNeedsUpdateConstraints()
        let inset = self.view.center.x - 1  // 1 – is half of the cell width
        collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)

        // Do any additional setup after loading the view.
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        guard !isLayouted else { return }

        collectionView.autoPinEdge(toSuperviewEdge: .top)
        collectionView.autoPinEdge(toSuperviewEdge: .leading)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
        collectionView.autoSetDimension(.height, toSize: 90)

        isLayouted = true
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    
}

extension ViewController: UIScrollViewDelegate {
//TODO: Fix force stop of scrolling
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        if let index = self.collectionView.indexPathForItem(at:self.collectionView.convert(self.collectionView.center, from: self.view)) {
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        } else {
            self.collectionView.scrollToItem(at: lastScrolledIndex, at: .centeredHorizontally, animated: true)
            return
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let index = self.collectionView.indexPathForItem(at: self.collectionView.convert(self.collectionView.center , from: self.view)) else {
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
