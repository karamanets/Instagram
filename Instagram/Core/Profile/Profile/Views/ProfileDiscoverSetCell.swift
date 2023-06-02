//
//  ProfileDiscoverCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 01/06/2023.
//

import UIKit
import SnapKit

final class ProfileDiscoverSetCell: UITableViewCell {
    
    //MARK: Public
    public func configure(with info: [DiscoverUserModel]) {
        self.dataService = info
        collectionView.reloadData()
    }
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        ///View
        contentView.backgroundColor = UIColor.theme.background
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UiConstants
    fileprivate enum UiConstants {
        static let minimumLineSpacing: CGFloat = 5
        static let itemInRowNumber: CGFloat = 2.5
        static let itemInRowTopBottomOffset: CGFloat = 16

    }
    
    //MARK: Private Property
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = UiConstants.minimumLineSpacing
        layout.minimumInteritemSpacing = .zero
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.alwaysBounceHorizontal = true
        ///Register cell
        view.register(ProfileDiscoverCell.self, forCellWithReuseIdentifier: String(describing: ProfileDiscoverCell.self))
        ///Register footer
        view.register(FooterForDiscoverCell.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: String(describing: FooterForDiscoverCell.self))
        return view
    }()
    
    private var dataService: [DiscoverUserModel] = []
}

//MARK: CollectionView Delegate
extension ProfileDiscoverSetCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("[⚠️] Selected item number: \(indexPath.item)")
    }

}

//MARK: CollectionView DataSource
extension ProfileDiscoverSetCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataService.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProfileDiscoverCell.self),
                                                      for: indexPath) as! ProfileDiscoverCell
        
        cell.configure(with: dataService[indexPath.item])
        
        return cell
    }
    
    ///Footer for DiscoverSetCell
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                     withReuseIdentifier: String(describing: FooterForDiscoverCell.self),
                                                                     for: indexPath) as! FooterForDiscoverCell
        header.configure(with: ["image1", "image2"])
        
        return header
    }
    
    ///Footer size  for DiscoverSetCell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        let width =  collectionView.bounds.width / 2.5
        
        let height =  collectionView.bounds.height
        
        return CGSize(width: width, height: height)
    }
}

//MARK: CollectionView Flow Layout
extension ProfileDiscoverSetCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width / UiConstants.itemInRowNumber
        
        let height = collectionView.bounds.height - UiConstants.itemInRowTopBottomOffset
        
        return CGSize(width: width, height: height)
    }
}
