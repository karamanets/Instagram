//
//  ReelsViewController.swift
//  Instagram
//
//  Created by Alex Karamanets on 27.04.2023.
//

import UIKit
import SnapKit
import AVKit

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
        static let spacingBetweenCell: CGFloat = 2
    }
    
    //MARK: Private Property
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = UiConstants.spacingBetweenCell
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.register(ReelsCell.self, forCellWithReuseIdentifier: String(describing: ReelsCell.self))
        return collection
    }()
    
    private lazy var scroll: UIScrollView? = nil
    
    ///DataService
    private let dataService = FakeDataService.shared
    
    private var reels: [ReelsModel] = []
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
        collectionView.prefetchDataSource = self
        
        
        scroll?.delegate = self
        
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
        print("Volume off")
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
        
        let index = indexPath.item
        
        cell.configure(with: dataService.reelsModels[index])
        
        if index == 0 {
            dataService.reelsModels[index].avpController.player?.play()
        }
        
        return cell
    }
}

extension ReelsViewController: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

       print(String(describing: indexPaths))

    }
}

extension ReelsViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let y = targetContentOffset.pointee.y
        let item = Int(y / view.frame.height)
        
        let current = item + 1
        
        let previous = current <= 0 ? 0 : current - 1

        dataService.reelsModels[current].avpController.player?.play()
        
        dataService.reelsModels[previous].avpController.player?.pause()
    }
    
}
