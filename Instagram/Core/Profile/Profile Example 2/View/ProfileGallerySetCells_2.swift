//
//  ProfileGallerySetCells.swift
//  Instagram
//
//  Created by Alex Karamanets on 27/05/2023.
//
//
import UIKit
import SnapKit

final class ProfileGallerySetCells_2: UITableViewCell {
    
    //MARK: Public
    public func configure(with info: [ProfileGalleryModel_2]) {
        self.items = info
    }
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Constants
    private enum UIConstants {

    }

    //MARK: Private properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor.theme.background
        ///Register Cell
        collectionView.register(ProfileGalleryCell_2.self,
                                forCellWithReuseIdentifier: String(describing: ProfileGalleryCell_2.self))
        return collectionView
    }()

    ///DataService
    var items: [ProfileGalleryModel_2] = []
}

//MARK: - Private methods
private extension ProfileGallerySetCells_2 {

    func initialize() {
        ///View
        contentView.backgroundColor = UIColor.theme.background
        
        ///Elements
        collectionView.delegate = self
        collectionView.dataSource = self
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: CollectionView DataSource
extension ProfileGallerySetCells_2: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                        String(describing: ProfileGalleryCell_2.self), for: indexPath) as! ProfileGalleryCell_2
        
        cell.configure(with: items[indexPath.item].imageName)
        
        return cell
    }
 
}

//MARK: CollectionView Delegate FlowLayout
extension ProfileGallerySetCells_2: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = contentView.bounds.width / 3.06
        
        let height = contentView.bounds.height / 6.8
        
        return CGSize(width: width, height: height)
    }
}

//MARK: CollectionView Delegate
extension ProfileGallerySetCells_2: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let index = indexPath.item

        print("[⚠️] Selected image number: \(index)")
    }
}

