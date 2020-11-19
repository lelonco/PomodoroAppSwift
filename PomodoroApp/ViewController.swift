//
//  ViewController.swift
//  PomodoroApp
//
//  Created by Yaroslav on 19.11.2020.
//

import UIKit
import PureLayout

class ViewController: UIViewController {

    var isLayouted = false
    let collectionView: UICollectionView = {
        let flowLayot = FadingLayout(scrollDirection: .horizontal)

//        flowLayot.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
//        flowLayot.itemSize = CGSize(width: 2, height: 50)
//        flowLayot.scrollDirection = .horizontal
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayot)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.contentMode = .scaleToFill
        collection.allowsMultipleSelection = false
        return collection
    }()
    var reuseIdentifier = "timerCollectionViewCell"
    init() {
        super.init(nibName: nil, bundle: nil)
        
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.dataSource = self
        collectionView.delegate = self
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
    
    func setupLayout() -> UICollectionViewLayout {
        
//        //TODO: Item
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.05), heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//        //TODO: Group
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        //TODO: Section
//        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 2, height: 50)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 15
        
        return layout
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let index = indexPath.item
        let width = (index % 5 == 0) ? (index.description.getCGSize(fontHeight: 15).width) : 2
        return CGSize(width: 2, height: 80)

    }
}

extension ViewController: UICollectionViewDelegate {
    
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let index = self.collectionView.indexPathForItem(at: self.collectionView.convert(self.collectionView.center , from: self.view)) else {
//            print(self.collectionView.center)
            return
        }
        guard let cell = self.collectionView.cellForItem(at: index) as? TimerCell else {
            return
        }
        cell.layer.opacity = 0.5
        print(index)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
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
