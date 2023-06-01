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

    }
    
    //MARK: Private Property
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.alwaysBounceHorizontal = true
        ///Register cell
        view.register(ProfileDiscoverCell.self, forCellWithReuseIdentifier: String(describing: ProfileDiscoverCell.self))

        return view
    }()
    
    private var dataService: [DiscoverUserModel] = []
}

//MARK: CollectionView Delegate
extension ProfileDiscoverSetCell: UICollectionViewDelegate {
    

}

//MARK: CollectionView DataSource
extension ProfileDiscoverSetCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataService.count
    }
    
    ///CollectionCell stories and gallery
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProfileDiscoverCell.self),
                                                      for: indexPath) as! ProfileDiscoverCell
        
        cell.configure(with: dataService[indexPath.item])
        
        return cell
    }
}

//MARK: CollectionView Flow Layout
extension ProfileDiscoverSetCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width / 4.7
        
        let height = collectionView.bounds.height - 16
        
        return CGSize(width: width, height: height)
    }
}

//==================== Cell

final class ProfileDiscoverCell: UICollectionViewCell {
    
    //MARK: Public
    public func configure(with info: DiscoverUserModel) {
        imageView.image = UIImage(named: info.image)
    }
    
    //MARK: UiConstants
    private enum UiConstants {
        static let imageSize: CGFloat = 80
        static let imageInset: CGFloat = 8
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(UiConstants.imageInset)
            make.size.equalTo(UiConstants.imageSize)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Property
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = UiConstants.imageSize / 2
        return view
    }()
    

}

