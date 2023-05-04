//
//  NewPostViewController.swift
//  Instagram
//
//  Created by Alex Karamanets on 27.04.2023.
//

import UIKit
import SnapKit

class NewPostViewController: UIViewController {

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: Constants
    private enum UIConstants {
        
    }

    //MARK: Private property
    private lazy var galleryButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.title = "Gallery"
        let transformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 22, weight: .semibold, width: .standard)
            return outgoing
        }
        config.titleTextAttributesTransformer = transformer
        config.baseForegroundColor = UIColor.theme.icons
        let image = UIImage(systemName: "chevron.down")?.withTintColor(UIColor.theme.icons, renderingMode: .alwaysOriginal)
        config.image = image
        config.imagePlacement = .trailing
        config.imagePadding = 2
        config.buttonSize = .medium
        config.baseBackgroundColor = .clear
        let button = UIButton(configuration: config, primaryAction: galleryButtonAction())
        return button
    }()
    
    private lazy var imageSelectButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "SELECT MULTIPLE"
        let transformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 16, weight: .medium, width: .condensed)
            return outgoing
        }
        config.titleTextAttributesTransformer = transformer
        config.titleAlignment = .center
        config.titlePadding = 10
        config.baseForegroundColor = UIColor.theme.icons
        config.baseBackgroundColor = UIColor.theme.iconBackground
        config.background.strokeColor = UIColor.theme.iconStroke
        config.background.strokeWidth = 0.2
        config.cornerStyle = .capsule
        let imageIcon = UIImage(systemName: "camera.on.rectangle.fill")
        config.image = imageIcon
        config.imagePlacement = .leading
        config.imagePadding = 7
        config.buttonSize = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 0, bottom: 7, trailing: 0)
        let button = UIButton(configuration: config, primaryAction: selectedButtonAction())
        button.imageView?.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.1)
        return button
    }()
    
    private lazy var imagePhotoButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor.theme.iconBackground
        config.baseForegroundColor = UIColor.theme.icons
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 0, bottom: 7, trailing: 0)
        config.background.strokeWidth = 0.3
        config.background.strokeColor = UIColor.theme.iconStroke
        let imageIcon = UIImage(systemName: "camera.circle.fill")
        config.image = imageIcon
        let button = UIButton(configuration: config, primaryAction: photoButtonAction())
        button.imageView?.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.2)
        return button
    }()
    
    private lazy var spacing: UIImageView = {
       let view = UIImageView()
        view.image = UIImage()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let mainImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "image2")
        view.backgroundColor = UIColor.theme.newPostImageBack
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(NewPostCell.self, forCellWithReuseIdentifier: String(describing: NewPostCell.self))
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    private lazy var sheetViewController: UIViewController = {
       let sheet = GallerySheet(nibName: nil, bundle: nil)
        sheet.modalPresentationStyle = .pageSheet
        return sheet
    }()
    
    //MARK: DataService
    private let items = FakeDataService()
    
    
}

//MARK: - Private methods
private extension NewPostViewController {
    
    func initialize() {
        /// Background view
        view.backgroundColor = UIColor.theme.background
        /// Navigation Elements
        navigationItem.leftBarButtonItems = makeLeftBarItem()
        navigationItem.rightBarButtonItem = makeRightBarItem()
        /// Methods
        makeTabBarIcon()
        
        /// Main Image
        view.addSubview(mainImage)
        mainImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height / 2.5)
        }
        
        /// Center HStack
        let HStackHeader = UIStackView(arrangedSubviews: [spacing, galleryButton, imageSelectButton, imagePhotoButton, spacing])
        HStackHeader.axis = .horizontal
        HStackHeader.alignment = .center
        HStackHeader.spacing = 10
        HStackHeader.backgroundColor = UIColor.theme.background
        HStackHeader.setCustomSpacing(20, after: galleryButton)
        HStackHeader.distribution = .fillProportionally
        view.addSubview(HStackHeader)
        HStackHeader.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(50)
        }
        
        /// CollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(HStackHeader.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    /// Bar bottom image title tag
    func makeTabBarIcon() {
        let image = UIImage(systemName: "plus.square")?.withTintColor(UIColor.theme.icons, renderingMode: .alwaysOriginal)
        let tabItem = UITabBarItem(title: "", image: image , tag: 2)
        self.tabBarItem = tabItem
    }
    
    /// Bar Item Left
    func makeLeftBarItem() -> [UIBarButtonItem] {
        /// Dismiss left Button
        let dismissButtonImage = UIImage(systemName: "xmark")?.withTintColor(UIColor.theme.icons, renderingMode: .alwaysOriginal)
        let dismissButton = UIBarButtonItem(image: dismissButtonImage, style: .plain, target: self, action: #selector(dismissButtonAction))
        
        /// Label
        let label = UILabel()
        label.text = "New Post"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        let navigationLabel = UIBarButtonItem(customView: label)
        
        return [dismissButton, navigationLabel]
    }
    
    /// Bar Item Right
    func makeRightBarItem() -> UIBarButtonItem {
        /// Next Button
        let nextButtonImage = UIImage(systemName: "arrow.forward")?.withTintColor(UIColor.theme.icons, renderingMode: .alwaysOriginal)
        let nextButton = UIBarButtonItem(image: nextButtonImage, style: .plain, target: self, action: #selector(nextButtonAction))
        
        return nextButton
    }
    
}

//MARK: Button Actions
private extension NewPostViewController {
    
    @objc func dismissButtonAction(_ sender: UIButton) {
        print("Add new Post")
    }
    
    @objc func nextButtonAction(_ sender: UIButton) {
        print("Next")
    }
    
    func galleryButtonAction() -> UIAction {
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            
            if
                #available(iOS 15.0, *),
                let sheet = self.sheetViewController.sheetPresentationController
            {
                sheet.detents = [.medium(), .large()]
            }
            self.present(self.sheetViewController, animated: true)
        }
        return action
    }
    
    func selectedButtonAction() -> UIAction {
        let action = UIAction { _ in
            print("Selected images")
        }
        return action
    }
    
    func photoButtonAction() -> UIAction {
        let action = UIAction { _ in
            print("Photo Button add")
        }
        return action
    }
}

//MARK: CollectionView DataSource
extension NewPostViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.arrayFakeDataImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NewPostCell.self), for: indexPath) as! NewPostCell
        
        cell.configure(with: items.arrayFakeDataImages[indexPath.item])
        
        return cell
    }
}

//MARK: UICollectionView Delegate Flow Layout
extension NewPostViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width / 4.075, height: view.bounds.height / 8)
    }
}

//MARK: CollectionView Delegate
extension NewPostViewController: UICollectionViewDelegate {
    
}

