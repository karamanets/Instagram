//
//  ReelsViewController.swift
//  Instagram
//
//  Created by Alex Karamanets on 27.04.2023.
//

import UIKit
import SnapKit

class ReelsViewController: UIViewController {

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: UiConstants
    private enum UiConstants {
        static let barItemHeight:CGFloat = 30
        static let barItemWidth: CGFloat = 34
    }
    
    //MARK: Private Property
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.register(ReelsCell.self, forCellWithReuseIdentifier: String(describing: ReelsCell.self))
        return collection
    }()
    
    ///DataService
    let dataService = FakeDataService.shared
}

//MARK: - Private Methods
private extension ReelsViewController {
    
    func initialize() {
        /// View
        view.backgroundColor = UIColor.theme.background
        
        /// Methods
        makeBarBottomIcon()
        
        /// Elements
        collectionView.backgroundColor = UIColor.theme.background
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    /// Bar bottom image title tag
    func makeBarBottomIcon() {
        let size = CGSize(width: UiConstants.barItemWidth, height: UiConstants.barItemHeight)
        
        let icon = UIImage(systemName: "play.rectangle.on.rectangle.fill")
        
        let image = icon?.imageResized(to: size).withTintColor(UIColor.theme.icons, renderingMode: .alwaysOriginal)
        
        let tabItem = UITabBarItem(title: "", image: image , tag: 3)
        self.tabBarItem = tabItem
    }
}

//MARK: CollectionView Delegate
extension ReelsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

//MARK: CollectionView Delegate FlowLayout
extension ReelsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let guide = view.safeAreaLayoutGuide
        
        let topSafeAreaHeight = guide.layoutFrame.size.height
        
        let width = view.bounds.width
        
        /// between reels spacing
        let height = topSafeAreaHeight - 2
        
        return CGSize(width: width, height: height )
    }
}

//MARK: CollectionView DataSource
extension ReelsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataService.reelsModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ReelsCell.self), for: indexPath) as! ReelsCell
        
        cell.configure(with: dataService.reelsModels[indexPath.item])
        
        return cell
    }
}
