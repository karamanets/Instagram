//
//  ProfileStoryCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 29/05/2023.
//

import UIKit
import SnapKit

final class ProfileHeader: UICollectionReusableView {
    
    //MARK: Public
    public func configure(with info: [ProfileStoryModel]) {
        self.items = info
        collectionView.reloadData()
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        static let userImageSize: CGFloat = 100
        static let textFont: CGFloat = 20
        static let textFontSubtitle: CGFloat = 15
        static let inset: CGFloat = 16
        static let buttonSize: CGFloat = 35
        static let spacingHStack: CGFloat = 10
        static let spacingVStack: CGFloat = 0
    }
    
    //MARK: Private Property
    private let userImage: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: "image1")
        view.image = image
        view.clipsToBounds = true
        view.layer.cornerRadius = UiConstants.userImageSize / 2
        return view
    }()
    
    private let numberOfPosts: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.icons
        view.textAlignment = .center
        view.text = "19"
        view.font = .systemFont(ofSize: UiConstants.textFont, weight: .heavy)
        return view
    }()
    
    private let postsLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.icons
        view.textAlignment = .center
        view.text = "Posts"
        view.font = .systemFont(ofSize: UiConstants.textFontSubtitle, weight: .heavy)
        return view
    }()
    
    private let numberOfFollowers: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.icons
        view.textAlignment = .center
        view.text = "9267"
        view.font = .systemFont(ofSize: UiConstants.textFont, weight: .heavy)
        return view
    }()
    
    private let followerLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.icons
        view.textAlignment = .center
        view.text = "Followers"
        view.font = .systemFont(ofSize: UiConstants.textFontSubtitle, weight: .heavy)
        return view
    }()
    
    private let numberOfFollowing: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.icons
        view.textAlignment = .center
        view.text = "199"
        view.font = .systemFont(ofSize: UiConstants.textFont, weight: .heavy)
        return view
    }()
    
    private let followingLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.icons
        view.textAlignment = .center
        view.text = "Following"
        view.font = .systemFont(ofSize: UiConstants.textFontSubtitle, weight: .heavy)
        return view
    }()
    
    private let storyHighlightsLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.icons
        view.textAlignment = .center
        view.text = "Story Highlights"
        view.font = .systemFont(ofSize: UiConstants.textFontSubtitle, weight: .medium)
        return view
    }()
    
    private let storyHighlightsSubtitleLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.icons
        view.textAlignment = .center
        view.text = "Keep your favourite stories on your profile"
        view.font = .systemFont(ofSize: UiConstants.textFontSubtitle - 2 , weight: .light)
        return view
    }()
    
    private lazy var editButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.title = "Edit Profile"
        let transformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: UiConstants.textFontSubtitle, weight: .semibold, width: .standard)
            return outgoing
        }
        config.titleTextAttributesTransformer = transformer
        config.baseForegroundColor = UIColor.theme.icons
        config.baseBackgroundColor = UIColor.theme.icons
        config.cornerStyle = .fixed
        let button = UIButton(configuration: config, primaryAction: editButtonAction())
        return button
    }()
    
    private lazy var discoverPeopleButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = UIColor.theme.icons
        config.baseBackgroundColor = UIColor.theme.iconBackground
        config.cornerStyle = .fixed
        let imageIcon = UIImage(systemName: "person.badge.plus.fill")
        config.image = imageIcon
        let button = UIButton(configuration: config, primaryAction: discoverPeopleButtonAction())

        return button
    }()
    
    private lazy var showRecommendButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = UIColor.theme.icons
        config.baseBackgroundColor = .clear
        let imageIcon = UIImage(systemName: "chevron.down")
        config.image = imageIcon
        let button = UIButton(configuration: config, primaryAction: discoverPeopleButtonAction())
        button.imageView?.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
        return button
    }()
    
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
        view.register(ProfileStoryCell.self, forCellWithReuseIdentifier: String(describing: ProfileStoryCell.self))

        return view
    }()
    
    ///DataCervice
    private var items: [ProfileStoryModel] = []
}

//MARK: - Private Methods
private extension ProfileHeader {
    
    func initialize() {
        ///View
        backgroundColor = UIColor.theme.background
        
        ///Element - userImage
        addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.size.equalTo(UiConstants.userImageSize)
            make.leading.equalToSuperview().inset(UiConstants.inset)
            make.top.equalToSuperview().inset(UiConstants.inset)
        }
        
        let posts = VStack(with: [numberOfPosts, postsLabel])
        let followers = VStack(with: [numberOfFollowers, followerLabel])
        let following = VStack(with: [numberOfFollowing, followingLabel])
        
        let HStack = HStack(with: [posts, followers, following])

        ///Element - HStack
        addSubview(HStack)
        HStack.snp.makeConstraints { make in
            make.leading.equalTo(userImage.snp.trailing).inset(-UiConstants.inset / 2)
            make.trailing.equalToSuperview().inset(UiConstants.inset)
            make.centerY.equalTo(userImage.snp.centerY)
        }
        
        ///Element - Edit Button
        addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(UiConstants.inset)
            make.leading.equalToSuperview().inset(UiConstants.inset / 2)
            make.trailing.equalToSuperview().inset(UiConstants.inset * 4 - UiConstants.inset)
            make.height.equalTo(UiConstants.buttonSize)
        }
        
        ///Element -  Discover People Button
        addSubview(discoverPeopleButton)
        discoverPeopleButton.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(UiConstants.inset)
            make.trailing.equalToSuperview().offset(-UiConstants.inset / 2)
            make.size.equalTo(UiConstants.buttonSize)
        }
        
        ///Element -  StoryHighlights Label
        addSubview(storyHighlightsLabel)
        storyHighlightsLabel.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(UiConstants.inset)
            make.leading.equalTo(editButton.snp.leading)
        }
        
        ///Element -  StoryHighlights Subtitle Label
        addSubview(storyHighlightsSubtitleLabel)
        storyHighlightsSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(storyHighlightsLabel.snp.bottom).offset(4)
            make.leading.equalTo(storyHighlightsLabel.snp.leading)
        }
        
        ///Element -  ShowRecommend Button
        addSubview(showRecommendButton)
        showRecommendButton.snp.makeConstraints { make in
            make.size.equalTo(UiConstants.inset)
            make.top.equalTo(storyHighlightsLabel.snp.top)
            make.trailing.equalTo(discoverPeopleButton.snp.trailing).offset(-UiConstants.inset / 2)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(storyHighlightsSubtitleLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func VStack(with view: [UIView]) -> UIStackView {
        
        let stack = UIStackView(arrangedSubviews: view)
        stack.backgroundColor = UIColor.theme.background
        /// config
        stack.axis = .vertical
        stack.spacing = UiConstants.spacingVStack
        stack.distribution = .fillProportionally
        stack.alignment = .center
        
        return stack
    }
    
    private func HStack(with view: [UIView]) -> UIStackView {
        
        let stack = UIStackView(arrangedSubviews: view)
        stack.backgroundColor = UIColor.theme.background
        /// config
        stack.axis = .horizontal
        stack.spacing = UiConstants.spacingHStack
        stack.distribution = .fillEqually
        stack.alignment = .center
        
        return stack
    }
    
    func editButtonAction() -> UIAction {
        let action = UIAction { _ in
            print("[⚠️] Edit button pressed")
        }
        return action
    }
    
    func discoverPeopleButtonAction() -> UIAction {
        let action = UIAction { _ in
            print("[⚠️] Discover people button pressed")
        }
        return action
    }
}

//MARK: CollectionView Delegate
extension ProfileHeader: UICollectionViewDelegate {
    

}

//MARK: CollectionView DataSource
extension ProfileHeader: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProfileStoryCell.self),
                                                      for: indexPath) as! ProfileStoryCell
        
        cell.configure(with: items[indexPath.item])
        
        return cell
    }
    
    ///Header for  story collection
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     withReuseIdentifier: String(describing: HeaderStoryButton.self),
                                                                     for: indexPath) as! HeaderStoryButton
        return header
    }
    
    ///Header size  for story collection
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let width =  collectionView.bounds.width / 5
        let height =  collectionView.bounds.width / 5
        
        return CGSize(width: width, height: height)
    }
}

//MARK: CollectionView Flow Layout
extension ProfileHeader: UICollectionViewDelegateFlowLayout {
    
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
        view.font = UIFont.systemFont(ofSize: ProfileHeader.UiConstants.labelNewSize, weight: .medium)
        view.textColor = UIColor.theme.icons
        view.textAlignment = .center
        return view
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(button)
        button.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(ProfileHeader.UiConstants.headerLeadingInset)
            make.top.equalToSuperview().offset(ProfileHeader.UiConstants.headerStoryOffSet)
            make.size.equalTo(ProfileHeader.UiConstants.headerStorySize)
        }
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(ProfileHeader.UiConstants.ofSetHeaderLabel)
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
