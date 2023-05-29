//
//  ProfileTableViewHeader.swift
//  Instagram
//
//  Created by Alex Karamanets on 25/05/2023.
//

import UIKit
import SnapKit

//MARK: TableView Header
final class ProfileTableViewHeader_2: UITableViewHeaderFooterView {
    
    //MARK: Public
    public func configure(with: String) {
        
    }
    
    //MARK: Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UiConstants
    private enum UiConstants {
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
}

//MARK: Private Methods
private extension ProfileTableViewHeader_2 {
    
    func initialize() {
        ///View
        contentView.backgroundColor = UIColor.theme.background
        
        ///Element - userImage
        contentView.addSubview(userImage)
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
        contentView.addSubview(HStack)
        HStack.snp.makeConstraints { make in
            make.leading.equalTo(userImage.snp.trailing).inset(-UiConstants.inset / 2)
            make.trailing.equalToSuperview().inset(UiConstants.inset)
            make.centerY.equalTo(userImage.snp.centerY)
        }
        
        ///Element - Edit Button
        contentView.addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(UiConstants.inset)
            make.leading.equalToSuperview().inset(UiConstants.inset / 2)
            make.trailing.equalToSuperview().inset(UiConstants.inset * 4 - UiConstants.inset)
            make.height.equalTo(UiConstants.buttonSize)
        }
        
        ///Element -  Discover People Button
        contentView.addSubview(discoverPeopleButton)
        discoverPeopleButton.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(UiConstants.inset)
            make.trailing.equalToSuperview().offset(-UiConstants.inset / 2)
            make.size.equalTo(UiConstants.buttonSize)
        }
        
        ///Element -  StoryHighlights Label
        contentView.addSubview(storyHighlightsLabel)
        storyHighlightsLabel.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(UiConstants.inset)
            make.leading.equalTo(editButton.snp.leading)
        }
        
        ///Element -  StoryHighlights Subtitle Label
        contentView.addSubview(storyHighlightsSubtitleLabel)
        storyHighlightsSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(storyHighlightsLabel.snp.bottom).offset(4)
            make.leading.equalTo(storyHighlightsLabel.snp.leading)
        }
        
        ///Element -  ShowRecommend Button
        contentView.addSubview(showRecommendButton)
        showRecommendButton.snp.makeConstraints { make in
            make.size.equalTo(UiConstants.inset)
            make.top.equalTo(storyHighlightsLabel.snp.top)
            make.trailing.equalTo(discoverPeopleButton.snp.trailing).offset(-UiConstants.inset / 2)
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
