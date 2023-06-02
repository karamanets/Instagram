//
//  ProfileDiscoverCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 02/06/2023.
//

import UIKit

final class ProfileDiscoverCell: UICollectionViewCell {
    
    //MARK: Public
    public func configure(with info: DiscoverUserModel) {
        imageView.image = UIImage(named: info.image)
        userName.text = info.name
        otherUsers.text = "\(info.followedUsers.first ?? "") + \(info.followedUsers.count) more"
    }
    
    //MARK: UiConstants
    fileprivate enum UiConstants {
        static let imageSize: CGFloat = 80
        static let imageInset: CGFloat = 16
        static let inset: CGFloat = 5
        static let insetBetweenSubText: CGFloat = 2
        static let insetImageLabel: CGFloat = 22
        static let mainFont: CGFloat = 15
        static let subFont: CGFloat = 12
        static let borderWidth: CGFloat = 0.5
        static let borderCorner: CGFloat = 10
        static let closeButtonSize: CGFloat = 25
        static let followButtonHeight: CGFloat = 30
        static let followButtonWidth: CGFloat = 120
        static let footerTopBottomOffset: CGFloat = 8
        static let footerImageBorderWidth: CGFloat = 3
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
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
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "xmark")?
            .withTintColor(UIColor.theme.icons, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let userName: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.textColor
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: UiConstants.mainFont, weight: .medium, width: .standard)
        return view
    }()
    
    private let followedByLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.icons
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: UiConstants.subFont, weight: .light, width: .standard)
        view.text = "Followed by"
        return view
    }()
    
    private let otherUsers: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.textColor
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: UiConstants.subFont, weight: .light, width: .standard)
        return view
    }()
    
    private lazy var followButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Follow"
        config.titleAlignment = .center
        let transformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: UiConstants.mainFont, weight: .semibold, width: .condensed)
            return outgoing
        }
        config.titleTextAttributesTransformer = transformer
        config.baseForegroundColor = .white
        config.baseBackgroundColor = UIColor.theme.customBlue
        let button = UIButton(configuration: config, primaryAction: followButtonAction())
        
        return button
    }()
}

//MARK: Private Methods for ProfileDiscoverCell
private extension ProfileDiscoverCell {
    
    func initialize() {
        backgroundColor = UIColor.theme.background
        layer.borderWidth = UiConstants.borderWidth
        layer.borderColor = UIColor.theme.iconBackground.cgColor
        clipsToBounds = true
        layer.cornerRadius = UiConstants.borderCorner
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UiConstants.imageInset)
            make.centerX.equalToSuperview()
            make.size.equalTo(UiConstants.imageSize)
        }
        
        addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UiConstants.inset)
            make.trailing.equalToSuperview().inset(UiConstants.inset)
            make.size.equalTo(UiConstants.closeButtonSize)
        }
        
        addSubview(userName)
        userName.snp.makeConstraints { make in
            make.centerX.equalTo(imageView.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(UiConstants.inset)
        }
        
        addSubview(followedByLabel)
        followedByLabel.snp.makeConstraints { make in
            make.centerX.equalTo(imageView.snp.centerX)
            make.top.equalTo(userName.snp.bottom).offset(UiConstants.inset)
        }
        
        addSubview(otherUsers)
        otherUsers.snp.makeConstraints { make in
            make.centerX.equalTo(imageView.snp.centerX)
            make.top.equalTo(followedByLabel.snp.bottom).offset(UiConstants.insetBetweenSubText)
        }
        
        addSubview(followButton)
        followButton.snp.makeConstraints { make in
            make.centerX.equalTo(imageView.snp.centerX)
            make.height.equalTo(UiConstants.followButtonHeight)
            make.width.equalTo(UiConstants.followButtonWidth)
            make.bottom.equalToSuperview().offset( -UiConstants.imageInset)
        }
    }
    
    //MARK: Button Actions
    @objc func closeButtonAction(_ sender: UIButton) {
        print("[⚠️] Close User pressed")
    }
    
    func followButtonAction() -> UIAction {
        let action = UIAction { _ in
            print("[⚠️] Follow user pressed")
        }
        return action
    }
}

//MARK: Footer for ProfileDiscoverCell
final class FooterForDiscoverCell: UICollectionReusableView {
    
    //MARK: Public
    public func configure(with info: [String]) {
        imageViewOne.image = UIImage(named: info.first ?? "")
        imageViewTwo.image = UIImage(named: info.last ?? "")
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Property
    private let imageViewOne: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = ProfileDiscoverCell.UiConstants.imageSize / 2
        return view
    }()
    
    private let imageViewTwo: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = ProfileDiscoverCell.UiConstants.imageSize / 2
        view.layer.borderWidth = ProfileDiscoverCell.UiConstants.footerImageBorderWidth
        view.layer.borderColor = UIColor.theme.background.cgColor
        return view
    }()
    
    private let labelOne: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.textColor
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: ProfileDiscoverCell.UiConstants.mainFont, weight: .medium, width: .standard)
        view.text = "Find More People"
        return view
    }()
    
    private let LabelTwo: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.theme.textColor
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: ProfileDiscoverCell.UiConstants.mainFont, weight: .medium, width: .standard)
        view.text = "to Follow"
        return view
    }()
    
    private lazy var seeAllButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "See all"
        config.titleAlignment = .center
        let transformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: ProfileDiscoverCell.UiConstants.mainFont, weight: .semibold, width: .condensed)
            return outgoing
        }
        config.titleTextAttributesTransformer = transformer
        config.baseForegroundColor = .white
        config.baseBackgroundColor = UIColor.theme.iconBackground
        let button = UIButton(configuration: config, primaryAction: followButtonAction())
        
        return button
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.theme.background
        view.clipsToBounds = true
        view.layer.cornerRadius = ProfileDiscoverCell.UiConstants.borderCorner
        view.layer.borderWidth = ProfileDiscoverCell.UiConstants.borderWidth
        view.layer.borderColor = UIColor.theme.iconBackground.cgColor
        return view
    }()
}

//MARK: Private Methods for FooterForDiscoverCell
private extension FooterForDiscoverCell {
    
    func initialize() {
        addSubview(container)
        container.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(ProfileDiscoverCell.UiConstants.inset)
            make.top.equalToSuperview().offset(ProfileDiscoverCell.UiConstants.footerTopBottomOffset)
            make.bottom.equalToSuperview().offset(-ProfileDiscoverCell.UiConstants.footerTopBottomOffset)
        }
        
        container.addSubview(imageViewOne)
        imageViewOne.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(ProfileDiscoverCell.UiConstants.imageInset)
            make.centerX.equalToSuperview()
            make.size.equalTo(ProfileDiscoverCell.UiConstants.imageSize)
        }
        
        container.addSubview(imageViewTwo)
        imageViewTwo.snp.makeConstraints { make in
            make.centerX.equalTo(imageViewOne).offset(ProfileDiscoverCell.UiConstants.imageInset)
            make.centerY.equalTo(imageViewOne).offset(ProfileDiscoverCell.UiConstants.imageInset)
            make.size.equalTo(ProfileDiscoverCell.UiConstants.imageSize)
        }
        
        container.addSubview(labelOne)
        labelOne.snp.makeConstraints { make in
            make.top.equalTo(imageViewOne.snp.bottom).offset(ProfileDiscoverCell.UiConstants.insetImageLabel)
            make.centerX.equalTo(imageViewOne.snp.centerX)
        }
        
        container.addSubview(LabelTwo)
        LabelTwo.snp.makeConstraints { make in
            make.top.equalTo(labelOne.snp.bottom).offset(ProfileDiscoverCell.UiConstants.inset)
            make.centerX.equalTo(imageViewOne.snp.centerX)
        }
        
        container.addSubview(seeAllButton)
        seeAllButton.snp.makeConstraints { make in
            make.centerX.equalTo(imageViewOne.snp.centerX)
            make.height.equalTo(ProfileDiscoverCell.UiConstants.followButtonHeight)
            make.width.equalTo(ProfileDiscoverCell.UiConstants.followButtonWidth)
            make.bottom.equalToSuperview().offset( -ProfileDiscoverCell.UiConstants.imageInset)
        }
    }
    
    func followButtonAction() -> UIAction {
        let action = UIAction { _ in
            print("[⚠️] See more people")
        }
        return action
    }
}
