//
//  ReelsCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 06/05/2023.
//

import UIKit
import SnapKit

final class ReelsCell: UICollectionViewCell {
    
    //MARK: Public
    public func configure(with info: ReelsModel) {
        numberOfLikes.text = "\(info.likes)"
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
        static let inset: CGFloat = 16
        static let reelsCornerRadius: CGFloat = 15
        static let reelsLabelFont: CGFloat = 26
        static let reelsIconWidth: CGFloat = 35
        static let reelsIconHeight: CGFloat = 30
        static let iconsScaleLike: CGFloat = 1.5
        static let iconsScaleComment: CGFloat = 1.3
        static let iconsNumbersFont: CGFloat = 18
    }
    
    //MARK: Private Property
    private var reels: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = UIConstant.reelsCornerRadius
        view.image = UIImage(named: "image5")
        return view
    }()
    
    private var labelReels: UILabel = {
        let label = UILabel()
        label.text = "Reels"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: UIConstant.reelsLabelFont, weight: .medium)
        return label
    }()
    
    private var reelsIcon: UIImageView = {
        let view = UIImageView()
        let image = UIImage(systemName: "camera.on.rectangle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        view.image = image
        return view
    }()
    
    private lazy var likesIconButton: UIButton = {
        let image =  UIImage(systemName: "heart")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        var config = UIButton.Configuration.plain()
        config.image = image
        config.baseForegroundColor = .white
        let button = UIButton(configuration: config, primaryAction: likeButtonAction())
        button.imageView?.layer.transform = CATransform3DMakeScale(
            UIConstant.iconsScaleLike, UIConstant.iconsScaleLike, UIConstant.iconsScaleLike)
        return button
    }()
    
    private var numberOfLikes: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIConstant.iconsNumbersFont, weight: .light)
        label.textColor = .white
        label.text = "0"
        return label
    }()
    
    private lazy var commentIconButton: UIButton = {
        let image = UIImage(systemName: "message")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white
        config.image = image
        let button = UIButton(configuration: config, primaryAction: commentButtonAction())
        button.imageView?.layer.transform = CATransform3DMakeScale(
            UIConstant.iconsScaleComment, UIConstant.iconsScaleComment, UIConstant.iconsScaleComment)
        return button
    }()
}

//MARK: Private Methods
private extension ReelsCell {
    
    func initialize() {
        
        addSubview(reels)
        reels.snp.makeConstraints { make in
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
        
        addSubview(likesIconButton)
        likesIconButton.snp.makeConstraints { make in
            make.trailing.equalTo(UIConstant.inset).inset(UIConstant.inset)
            make.top.equalTo(snp.centerY).offset(UIConstant.inset * 5)
        }
        
        addSubview(numberOfLikes)
        numberOfLikes.snp.makeConstraints { make in
            make.top.equalTo(likesIconButton.snp.bottom).offset(UIConstant.inset)
            make.centerX.equalTo(likesIconButton.snp.centerX)
        }
        
        addSubview(commentIconButton)
        commentIconButton.snp.makeConstraints { make in
            make.top.equalTo(numberOfLikes.snp.bottom).offset(UIConstant.inset * 2)
            make.centerX.equalTo(likesIconButton.snp.centerX)
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
}
