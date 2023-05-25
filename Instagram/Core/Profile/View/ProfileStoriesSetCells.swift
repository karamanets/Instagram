//
//  ProfileStoriesSetCells.swift
//  Instagram
//
//  Created by Alex Karamanets on 23/05/2023.
//

import UIKit
import SnapKit

final class ProfileStoriesSetCells: UITableViewCell {
    
    //MARK: Public
    public func configure(with images: [UIImage]) {
        self.imagesArray = images
        collectionView.reloadData()
    }
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UiConstants
    fileprivate enum UiConstants {
        static let headerStorySize: CGFloat = 80
        static let headerStoryOffSet: CGFloat = 8
        static let labelNewSize: CGFloat = 15
        static let ofSetHeaderLabel: CGFloat = 3
        static let headerLeadingInset: CGFloat = 8
    }
    
    //MARK: Private Property
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        ///Register header
        view.register(HeaderStoryButton.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: String(describing: HeaderStoryButton.self))
        ///Register cell
        view.register(ProfileStoriesCell.self, forCellWithReuseIdentifier: String(describing: ProfileStoriesCell.self))
        
        
        return view
    }()
    
    private var imagesArray: [UIImage] = []
}

//MARK: - Private Methods
private extension ProfileStoriesSetCells {
    
    func initialize() {
        ///View
        contentView.backgroundColor = UIColor.theme.background
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(contentView.bounds.height * 2.6)
        }
    }
}

//MARK: CollectionView Delegate
extension ProfileStoriesSetCells: UICollectionViewDelegate {
    
}

//MARK: CollectionView DataSource
extension ProfileStoriesSetCells: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    ///CollectionCell stories and gallery
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProfileStoriesCell.self),
                                                      for: indexPath) as! ProfileStoriesCell
        
        cell.configure(with: imagesArray[indexPath.item])
        
        return cell
    }
    
    ///Header for ProfileStoriesCell -> CollectionView
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     withReuseIdentifier: String(describing: HeaderStoryButton.self),
                                                                     for: indexPath) as! HeaderStoryButton
        return header
    }
    
    ///Header size  for ProfileStoriesCell -> CollectionView
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let width =  collectionView.bounds.width / 5
        let height =  collectionView.bounds.width / 5
        
        return CGSize(width: width, height: height)
    }
}

//MARK: CollectionView Flow Layout
extension ProfileStoriesSetCells: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width / 4.7
        
        let height = collectionView.bounds.height - 16
        
        return CGSize(width: width, height: height)
    }
}

//MARK: HeaderView Add Button
final class HeaderStoryButton: UICollectionReusableView {
    
    //MARK: Fileprivate
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "storyImage")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.text = "New"
        view.font = UIFont.systemFont(ofSize: ProfileStoriesSetCells.UiConstants.labelNewSize, weight: .medium)
        view.textColor = UIColor.theme.icons
        view.textAlignment = .center
        return view
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(button)
        button.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(ProfileStoriesSetCells.UiConstants.headerLeadingInset)
            make.top.equalToSuperview().offset(ProfileStoriesSetCells.UiConstants.headerStoryOffSet)
            make.size.equalTo(ProfileStoriesSetCells.UiConstants.headerStorySize)
        }
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(ProfileStoriesSetCells.UiConstants.ofSetHeaderLabel)
            make.centerX.equalTo(button.snp.centerX)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func addButtonAction(_ sender: UIButton) {
        print("[⚠️] Profile add story")
    }
}
