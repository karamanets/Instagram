//
//  ProfileStoryCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 29/05/2023.
//

import UIKit
import SnapKit

//MARK: Custom Delegate for show story
protocol ProfileShowStoryDelegate {
    
    func didChange(_ show: Bool)
}

//MARK: Custom Delegate for show Discover
protocol ProfileShowDiscoverDelegate {
    
    func didChangeDiscoverSize(_ show: Bool)
}

final class ProfileHeader: UICollectionReusableView {
    
    //MARK: Public
    public func configure(with info: [ProfileStoryModel], user: UserModel) {
        items = info
        userImage.image = UIImage(named: user.userImage)
        numberOfPosts.text = "\(user.posts)"
        numberOfFollowers.text = "\(user.followers)"
        numberOfFollowing.text = "\(user.following)"
        collectionView.reloadData()
    }
    
    public var showStoryDelegate: ProfileShowStoryDelegate?
    
    public var showDiscoverDelegate: ProfileShowDiscoverDelegate?
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UiConstants
    private enum UiConstants {
        static let textFont: CGFloat = 20
        static let textFontSubtitle: CGFloat = 15
        static let inset: CGFloat = 16
        static let buttonSize: CGFloat = 35
        static let spacingHStack: CGFloat = 10
        static let spacingVStack: CGFloat = 0
    }
    
    //MARK: Private Property
    private lazy var userImage: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = customSizeUserImage
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let numberOfPosts: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.textColor
        view.textAlignment = .center
        view.font = .systemFont(ofSize: UiConstants.textFont, weight: .heavy)
        return view
    }()
    
    private let postsLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.textColor
        view.textAlignment = .center
        view.text = "Posts"
        view.font = .systemFont(ofSize: UiConstants.textFontSubtitle, weight: .heavy)
        return view
    }()
    
    private let numberOfFollowers: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.textColor
        view.textAlignment = .center
        view.font = .systemFont(ofSize: UiConstants.textFont, weight: .heavy)
        return view
    }()
    
    private let followerLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.textColor
        view.textAlignment = .center
        view.text = "Followers"
        view.font = .systemFont(ofSize: UiConstants.textFontSubtitle, weight: .heavy)
        return view
    }()
    
    private let numberOfFollowing: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.textColor
        view.textAlignment = .center
        view.font = .systemFont(ofSize: UiConstants.textFont, weight: .heavy)
        return view
    }()
    
    private let followingLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.textColor
        view.textAlignment = .center
        view.text = "Following"
        view.font = .systemFont(ofSize: UiConstants.textFontSubtitle, weight: .heavy)
        return view
    }()
    
    private let storyHighlightsLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.textColor
        view.textAlignment = .center
        view.text = "Story Highlights"
        view.font = .systemFont(ofSize: UiConstants.textFontSubtitle, weight: .medium)
        return view
    }()
    
    private lazy var storyHighlightsSubtitleLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.textColor
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
    
    private lazy var showStoryButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = UIColor.theme.textColor
        config.baseBackgroundColor = .clear
        let imageIcon = UIImage(systemName: "chevron.down")
        config.image = imageIcon
        let button = UIButton(configuration: config, primaryAction: showStoryButtonAction())
        button.imageView?.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.2)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.alwaysBounceVertical = false
        ///Register header
        view.register(HeaderStoryButton.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: String(describing: HeaderStoryButton.self))
        ///Register cell
        view.register(ProfileStoryCell.self, forCellWithReuseIdentifier: String(describing: ProfileStoryCell.self))

        return view
    }()
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.showsVerticalScrollIndicator = false
        view.separatorColor = UIColor.theme.background
        view.backgroundColor = UIColor.theme.background
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = true
        view.isScrollEnabled = false
        view.rowHeight = 230
        ///Remove space top
        view.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        ///Register cells
        view.register(ProfileDiscoverSetCell.self, forCellReuseIdentifier: String(describing: ProfileDiscoverSetCell.self))

        return view
    }()
    
    ///DataCervice
    private var items: [ProfileStoryModel] = []
    
    private let dataService = FakeDataService.shared
    
    ///Make cornerRadius for user image
    private var customSizeUserImage: CGFloat = .zero
    
    private var showStory: Bool = true
    
    private var showDiscover: Bool = true
}

//MARK: - Private Methods
private extension ProfileHeader {
    
    func initialize() {
        ///View
        backgroundColor = UIColor.theme.background
        
        ///Size for User image
        let imageSize = bounds.width / 4.2
        customSizeUserImage = imageSize / 2
        
        ///Element - userImage
        addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.size.equalTo(imageSize)
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
        
        ///Element - TableView
        addSubview(tableView)
        tableView.dataSource = self
        tableView.alpha = showDiscover ? 1.0 : .zero
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(editButton.snp.bottom)
            make.height.equalTo(showDiscover ? 230 : .zero)
        }
        
        ///Element -  StoryHighlights Label
        addSubview(storyHighlightsLabel)
        storyHighlightsLabel.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(UiConstants.inset)
            make.leading.equalTo(editButton.snp.leading)
        }
        
        ///Element -  StoryHighlights Subtitle Label
        addSubview(storyHighlightsSubtitleLabel)
        storyHighlightsSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(storyHighlightsLabel.snp.bottom).offset(6)
            make.leading.equalTo(storyHighlightsLabel.snp.leading)
        }
        
        ///Element -  ShowRecommend Button
        addSubview(showStoryButton)
        showStoryButton.snp.makeConstraints { make in
            make.size.equalTo(UiConstants.inset)
            make.top.equalTo(storyHighlightsLabel.snp.top)
            make.trailing.equalTo(discoverPeopleButton.snp.trailing).offset(-UiConstants.inset / 2)
        }
        
        ///Element - CollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(storyHighlightsSubtitleLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func VStack(with view: [UIView]) -> UIStackView {
        
        let stack = UIStackView(arrangedSubviews: view)
        stack.backgroundColor = UIColor.theme.background
        /// config
        stack.axis = .vertical
        stack.spacing = UiConstants.spacingVStack
        stack.distribution = .fillProportionally
        stack.alignment = .center
        
        return stack
    }
    
    func HStack(with view: [UIView]) -> UIStackView {
        
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
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.showDiscover.toggle()
  
            self.showDiscoverDelegate?.didChangeDiscoverSize(self.showDiscover)
        }
        return action
    }
    
    func showStoryButtonAction() -> UIAction {
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.showStory.toggle()
            self.storyHighlightsSubtitleLabel.alpha = self.showStory ? 1.0 : 0.0
            self.collectionView.alpha = self.showStory ? 1.0 : 0.0
            self.showStoryDelegate?.didChange(self.showStory)
            
            UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseInOut) {
                let upsideDown = CGAffineTransform(rotationAngle: .pi * -0.999)
                self.showStoryButton.transform = self.showStory ? .identity : upsideDown
            }
        }
        return action
    }
}

//MARK: CollectionView Delegate
extension ProfileHeader: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("[⚠️] Selected image: \(indexPath.item)")
    }

}

//MARK: CollectionView DataSource
extension ProfileHeader: UICollectionViewDataSource {
    
    ///Count Cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    ///Configure cell
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
        
        let height = collectionView.bounds.height - UiConstants.inset
        
        return CGSize(width: width, height: height)
    }
}

//MARK: TableView DataSource
extension ProfileHeader: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileDiscoverSetCell.self),
                                                 for: indexPath) as! ProfileDiscoverSetCell
        cell.configure(with: dataService.discoverUsers)
        
        return cell
    }
}
