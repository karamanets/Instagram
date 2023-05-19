//
//  ReelsCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 06/05/2023.
//

import UIKit
import SnapKit
import AVFoundation
import AVKit

final class ReelsCell: UICollectionViewCell {
    
    //MARK: Public
    public func configure(with info: ReelsModel) {
        setUpReels(with: info)
        numberOfLikes.text = String(describing: info.numberOfLikes)
        numberOfComments.text = String(describing: info.numberOfComment)
        numberOfShared.text = String(describing: info.numberOfShare)
        rightUserImage.image = info.reelsUser.userImage
        descriptionText.text = info.comment.first
        leftUserImage.image = info.reelsUser.userImage
        userName.text = info.reelsUser.userName
        
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UIConstant
    private enum UIConstant {
        static let inset: CGFloat = 15
        static let topOfLeftIcons = 35
        static let reelsCornerRadius: CGFloat = 15
        static let reelsLabelFont: CGFloat = 26
        static let reelsIconWidth: CGFloat = 35
        static let reelsIconHeight: CGFloat = 30
        static let iconsScale: CGFloat = 1.2
        static let spacingRightIconsToNumbers: CGFloat = 4
        static let iconsNumbersFont: CGFloat = 18
        static let iconToLabelSpacing: CGFloat = 2
        static let rightImageSize: CGFloat = 40
        static let leftImageSize: CGFloat = 35
        
    }
    
    //MARK: Private Property
    private let reelsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    private lazy var avpController: AVPlayerViewController = {
        let view = AVPlayerViewController()
        view.showsPlaybackControls = false
        return view
    }()
    
    private lazy var labelReels: UILabel = {
        let label = UILabel()
        label.text = "Reels"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: UIConstant.reelsLabelFont, weight: .medium)
        return label
    }()
    
    private lazy var reelsIcon: UIImageView = {
        let view = UIImageView()
        let image = UIImage(systemName: "camera.on.rectangle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        view.image = image
        return view
    }()
    
    private lazy var likesIconButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "heart")
        config.baseForegroundColor = .white
        let button = UIButton(configuration: config, primaryAction: likeButtonAction())
        button.imageView?.layer.transform = CATransform3DMakeScale(
            UIConstant.iconsScale, UIConstant.iconsScale, UIConstant.iconsScale)
        return button
    }()
    
    private lazy var numberOfLikes: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIConstant.iconsNumbersFont, weight: .light)
        label.textColor = .white
        label.text = "0"
        return label
    }()
    
    private lazy var commentIconButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "message")
        config.baseForegroundColor = .white
        let button = UIButton(configuration: config, primaryAction: commentButtonAction())
        button.imageView?.layer.transform = CATransform3DMakeScale(
            UIConstant.iconsScale, UIConstant.iconsScale, UIConstant.iconsScale)
        return button
    }()
    
    private lazy var numberOfComments: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIConstant.iconsNumbersFont, weight: .light)
        label.textColor = .white
        label.text = "0"
        return label
    }()
    
    private lazy var sharedButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "paperplane")
        config.baseForegroundColor = .white
        let button = UIButton(configuration: config, primaryAction: sharedButtonAction())
        button.imageView?.layer.transform = CATransform3DMakeScale(
            UIConstant.iconsScale, UIConstant.iconsScale, UIConstant.iconsScale)
        return button
    }()
    
    private lazy var numberOfShared: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIConstant.iconsNumbersFont, weight: .light)
        label.textColor = .white
        label.text = "0"
        return label
    }()
    
    private lazy var menuButton: UIButton = {
        var config = UIButton.Configuration.plain()
        let image =  UIImage(systemName: "ellipsis")
        config.image = image
        config.baseForegroundColor = .white
        let button = UIButton(configuration: config, primaryAction: sharedButtonAction())
        button.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
        return button
    }()
    
    private lazy var rightUserImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person")
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    private lazy var musicIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "lines.measurement.horizontal")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return view
    }()
    
    private lazy var musicLabel: UILabel = {
        let label = UILabel()
        label.text = "github.com/karamanets"
        label.textColor = .white
        return label
    }()
    
    private lazy var locationIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "globe.europe.africa")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return view
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Ukraine"
        label.textColor = .white
        return label
    }()
    
    private lazy var descriptionText: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        text.numberOfLines = 1
        text.text = ""
        text.textColor = .white
        return text
    }()
    
    private lazy var leftUserImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person")
        view.clipsToBounds = true
        view.layer.cornerRadius = UIConstant.leftImageSize / 2
        return view
    }()
    
    private lazy var userName: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.textColor = .white
        return name
    }()
    
    private lazy var followButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.title = "Follow"
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        config.background.strokeWidth = 1
        config.background.strokeColor = .white
        config.buttonSize = .medium
        
        let button = UIButton(configuration: config, primaryAction: followButtonAction())
        return button
    }()
    
}

//MARK: - Private Methods
private extension ReelsCell {
    
    func initialize() {
        
        addSubview(reelsContainer)
        reelsContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(labelReels)
        labelReels.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(UIConstant.inset)
        }
        
        addSubview(reelsIcon)
        reelsIcon.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(UIConstant.inset)
            make.height.equalTo(UIConstant.reelsIconHeight)
            make.width.equalTo(UIConstant.reelsIconWidth)
        }
        
        addSubview(musicIcon)
        musicIcon.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-UIConstant.inset)
            make.leading.equalToSuperview().inset(UIConstant.inset)
        }
        
        addSubview(rightUserImage)
        rightUserImage.snp.makeConstraints { make in
            make.width.height.equalTo(UIConstant.rightImageSize)
            make.bottom.equalTo(musicIcon.snp.bottom)
            make.trailing.equalToSuperview().inset(UIConstant.inset)
        }
        
        addSubview(menuButton)
        menuButton.snp.makeConstraints { make in
            make.bottom.equalTo(rightUserImage.snp.top).offset(-UIConstant.inset)
            make.centerX.equalTo(rightUserImage.snp.centerX)
        }
        
        addSubview(numberOfShared)
        numberOfShared.snp.makeConstraints { make in
            make.bottom.equalTo(menuButton.snp.top).offset(-UIConstant.inset)
            make.centerX.equalTo(rightUserImage.snp.centerX)
        }
        
        addSubview(sharedButton)
        sharedButton.snp.makeConstraints { make in
            make.bottom.equalTo(numberOfShared.snp.top).offset(-UIConstant.spacingRightIconsToNumbers)
            make.centerX.equalTo(rightUserImage.snp.centerX)
        }
        
        addSubview(numberOfComments)
        numberOfComments.snp.makeConstraints { make in
            make.bottom.equalTo(sharedButton.snp.top).offset(-UIConstant.inset)
            make.centerX.equalTo(rightUserImage.snp.centerX)
        }
        
        addSubview(commentIconButton)
        commentIconButton.snp.makeConstraints { make in
            make.bottom.equalTo(numberOfComments.snp.top).offset(-UIConstant.spacingRightIconsToNumbers)
            make.centerX.equalTo(rightUserImage.snp.centerX)
        }
        
        addSubview(numberOfLikes)
        numberOfLikes.snp.makeConstraints { make in
            make.bottom.equalTo(commentIconButton.snp.top).offset(-UIConstant.inset)
            make.centerX.equalTo(rightUserImage.snp.centerX)
        }
        
        addSubview(likesIconButton)
        likesIconButton.snp.makeConstraints { make in
            make.bottom.equalTo(numberOfLikes.snp.top).inset(-UIConstant.spacingRightIconsToNumbers)
            make.centerX.equalTo(rightUserImage.snp.centerX)
        }
        
        addSubview(musicLabel)
        musicLabel.snp.makeConstraints { make in
            make.leading.equalTo(musicIcon.snp.trailing).inset(-UIConstant.iconToLabelSpacing)
            make.centerY.equalTo(musicIcon.snp.centerY)
        }
        
        addSubview(locationIcon)
        locationIcon.snp.makeConstraints { make in
            make.leading.equalTo(musicLabel.snp.trailing).inset(-UIConstant.inset)
            make.centerY.equalTo(musicIcon.snp.centerY)
        }
        
        addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.leading.equalTo(locationIcon.snp.trailing).inset(-UIConstant.iconToLabelSpacing)
            make.centerY.equalTo(musicIcon.snp.centerY)
        }
        
        addSubview(descriptionText)
        descriptionText.snp.makeConstraints { make in
            make.bottom.equalTo(musicIcon.snp.top).offset(-UIConstant.inset)
            make.leading.equalToSuperview().inset(UIConstant.inset)
        }
        
        addSubview(leftUserImage)
        leftUserImage.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionText.snp.top).offset(-UIConstant.inset)
            make.leading.equalToSuperview().inset(UIConstant.inset)
            make.height.width.equalTo(UIConstant.leftImageSize)
        }
        
        addSubview(userName)
        userName.snp.makeConstraints { make in
            make.leading.equalTo(leftUserImage.snp.trailing).inset(-UIConstant.inset)
            make.centerY.equalTo(leftUserImage.snp.centerY)
        }
        
        addSubview(followButton)
        followButton.snp.makeConstraints { make in
            make.leading.equalTo(userName.snp.trailing).inset(-UIConstant.inset)
            make.centerY.equalTo(leftUserImage.snp.centerY)
        }
        
    }
    
    func setUpReels(with info: ReelsModel)  {
        guard let path = Bundle.main.path(forResource: info.reels, ofType: "mp4") else { return }
        
        let url = URL(filePath: path)
        
        let player = AVPlayer(url: url)
        
        avpController.player = player
        
        avpController.view.frame = self.reelsContainer.bounds
        
        self.reelsContainer.addSubview(avpController.view)
        
        player.volume = Float(info.volume)
        
        if info.isPlay {
            player.play()
        }
    }
}

//MARK: Button Action
private extension ReelsCell {
    
    func likeButtonAction() -> UIAction {
        let action = UIAction { [weak self] _ in
            guard let _ = self else { return }
            
            print("[⚠️] Pressed like button")
        }
        return action
    }
    
    func commentButtonAction() -> UIAction {
        let action = UIAction { [weak self] _ in
            guard let _ = self else { return }
            print("[⚠️] Pressed comment button")
        }
        return action
    }
    
    func sharedButtonAction() -> UIAction {
        let action = UIAction { [weak self] _ in
            guard let _ = self else { return }
            
            print("[⚠️] Pressed shared button")
        }
        return action
    }
    
    func followButtonAction() -> UIAction {
        let action = UIAction { [weak self] _ in
            guard let _ = self else { return }
        
            print("[⚠️] Pressed Follow button")
        }
        return action
    }
}
