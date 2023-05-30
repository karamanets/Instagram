//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Alex Karamanets on 29/05/2023.
//

import UIKit
import SnapKit


class ProfileViewController: UIViewController {

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    //MARK: UiConstants
    private enum UiConstants {
        static let barItemSize:CGFloat = 30
        static let insetHeaderToCollectionCell:CGFloat = 25
    }

    //MARK: Private Property
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        ///Register header
        view.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: String(describing: ProfileHeader.self))
        ///Register cell
        view.register(ProfileGalleryCell.self, forCellWithReuseIdentifier: String(describing: ProfileGalleryCell.self))

        return view
    }()

    ///DataService
    let dataService = FakeDataService.shared
    
    var showStory: Bool = true
}

//MARK: - Private methods
private extension ProfileViewController {

    func initialize() {
        ///View
        view.backgroundColor = UIColor.theme.background
        navigationController?.navigationBar.tintColor = UIColor.theme.icons

        navigationItem.leftBarButtonItems = makeLeftBarButtonItem()
        navigationItem.rightBarButtonItems = makeRightBarButtonItem()

        ///Methods
        makeBarBottomIcon()

        ///Elements
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateCollectionSize() {
        self.showStory.toggle()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func getHeight(with size: CGFloat) -> CGFloat {
        let heightSE = collectionView.bounds.height / 2 - UiConstants.insetHeaderToCollectionCell
        let heightMAX = collectionView.bounds.height / 3 + UiConstants.insetHeaderToCollectionCell
        
        if size > 700 {
            return heightMAX
        } else {
            return heightSE
        }
    }
}

//MARK: Bar Items
private extension ProfileViewController {

    /// Bar bottom image title tag
    func makeBarBottomIcon() {

        let size = CGSize(width: UiConstants.barItemSize, height: UiConstants.barItemSize)

        let radius = size.width / 2

        let image = dataService.userImage?
            .imageResized(to: size)
            .withCorner(radius: radius)?
            .withRenderingMode(.alwaysOriginal)

        let tabItem = UITabBarItem(title: "", image: image , tag: 4)
        self.tabBarItem = tabItem
    }

    /// Bar Button left
    func makeLeftBarButtonItem() -> [UIBarButtonItem] {

        let user = dataService.userName

        /// Add logo mage
        let userName = UIBarButtonItem(title: user,
                                       style: .done,
                                       target: self,
                                       action: #selector(userNameAction))
        /// Add bar button
        let addAccount = UIBarButtonItem(image: UIImage(systemName: "chevron.down"),
                                         style: .done,
                                         target: self,
                                         action: #selector(addAccountAction))
        /// return logo and button
        return [userName, addAccount]
    }

    /// Bar Buttons right
    func makeRightBarButtonItem() -> [UIBarButtonItem] {
        /// Two button
        let createButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app"),
                                               style: .plain,
                                               target: self,
                                               action: #selector(createButtonAction))

        let settingsButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(settingsButtonAction))
        return [settingsButtonItem, createButtonItem]
    }

    /// Left Bar Button Actions
    @objc func userNameAction() {
        print("[⚠️] About account")
    }
    @objc func addAccountAction() {
        print("[⚠️] Change Account button pressed")
    }

    /// Right Bar Button Actions
    @objc func createButtonAction() {
        print("[⚠️] Created button pressed")
    }
    @objc func settingsButtonAction() {
        print("[⚠️] Settings button pressed")
        updateCollectionSize()
    }

}

//MARK: CollectionView DataSource
extension ProfileViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataService.profileGallery.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProfileGalleryCell.self),
                                                      for: indexPath) as! ProfileGalleryCell

        cell.configure(with: dataService.profileGallery[indexPath.item])

        return cell
    }
    
    ///Header for Profile ViewController
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     withReuseIdentifier: String(describing: ProfileHeader.self),
                                                                     for: indexPath) as! ProfileHeader
        header.configure(with: dataService.profileStory)
        
        return header
    }
    
    ///Header size  for Profile ViewController
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let width =  collectionView.bounds.width
        
        let height = getHeight(with: collectionView.bounds.height)

        let heightClose = getHeight(with: collectionView.bounds.height) - collectionView.bounds.width / 3.4
        
        return CGSize(width: width, height: showStory ? height : heightClose )
    }
}

//MARK: CollectionView Delegate
extension ProfileViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let index = indexPath.item

        print("[⚠️] Selected image number: \(index)")
    }
}

//MARK: CollectionView Delegate FlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = view.bounds.width / 3.0666

        let height = view.bounds.height / 6.8

        return CGSize(width: width, height: height)
    }
}
