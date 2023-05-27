//
//  PostCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 19.04.2023.
//

import UIKit
import SnapKit

final class PostCell: UITableViewCell {
    
    //MARK: Public
    func configure(with info: HomePostModel) {
        userImage.image = info.userImage
        userName.text = info.userName
        subtitle.text = info.postSubtitle
        postImage.image = info.postImage
        likesLabel.text = "\(info.numberOfLikes) Likes"
        if let comment = info.comment {
            configureComment(with: comment)
        }
    }
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Constants
    private enum UiConstants {
        static let userImageSize: CGFloat = 30
        static let contentInset: CGFloat = 12
        static let userNameStackOffset: CGFloat = 12
        static let postImageToUserImageOffset: CGFloat = 6
        static let actionStackHeight: CGFloat = 24
        static let actionStackToPostImageOffset: CGFloat = 12
        static let actionStackSpacing: CGFloat = 12
        static let likesLabelToActionStackOffset: CGFloat = 12
        static let userNameFontSize: CGFloat = 14
        static let subtitleFontSize: CGFloat = 10
        static let commentLabelFont: CGFloat = 14
        static let commentToLikeTopOffset: CGFloat = 12
        static let bookMarkButtonToPostImageOffset:CGFloat = 12
    }
    
    //MARK: Private Property
    private lazy var userImage: UIImageView = {
       let view = UIImageView()
        view.layer.cornerRadius = UiConstants.userImageSize / 2
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UiConstants.userNameFontSize, weight: .bold)
        return label
    }()
    
    private lazy var subtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UiConstants.subtitleFontSize, weight: .light)
        return label
    }()
    
    private lazy var optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = UIColor.theme.icons
        button.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
        return button
    }()
    
    private lazy var postImage: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "LogoPost")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.theme.icons
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.theme.icons
        button.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        return button
    }()
    
    private lazy var sharedButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.theme.icons
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        return button
    }()
    
    private lazy var likesLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UiConstants.subtitleFontSize, weight: .bold)
        return label
    }()
    
    private lazy var bookMarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.theme.icons
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        return button
    }()
    
    private lazy var commentLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UiConstants.commentLabelFont)
        label.numberOfLines = 5
        return label
    }()
}

//MARK: - Private Methods
private extension PostCell {
    
    func initialize() {
        
        buttonsAction()
        selectionStyle = .none
        
        /// userImage - right
        contentView.addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(UiConstants.contentInset)
            make.top.equalToSuperview()
            make.size.equalTo(UiConstants.userImageSize)
        }
        
        /// Stack with userName and subtitle - left
        let userNameStack = UIStackView()
        userNameStack.axis = .vertical
        userNameStack.addArrangedSubview(userName)
        userNameStack.addArrangedSubview(subtitle)
        contentView.addSubview(userNameStack)
        userNameStack.snp.makeConstraints { make in
            make.centerY.equalTo(userImage)
            make.leading.equalTo(userImage.snp.trailing).offset(UiConstants.userNameStackOffset)
        }
        
        /// OptionsButton - left
        contentView.addSubview(optionsButton)
        optionsButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(UiConstants.contentInset)
        }
        
        /// Main imagePost
        contentView.addSubview(postImage)
        postImage.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(userImage.snp.bottom).offset(UiConstants.postImageToUserImageOffset)
            make.height.equalTo(contentView.snp.width)
        }
        
        /// Stack with buttons - below post Image
        let actionsStack = UIStackView()
        actionsStack.axis = .horizontal
        actionsStack.spacing = UiConstants.actionStackSpacing
        actionsStack.addArrangedSubview(likeButton)
        actionsStack.addArrangedSubview(commentButton)
        actionsStack.addArrangedSubview(sharedButton)
        contentView.addSubview(actionsStack)
        actionsStack.snp.makeConstraints { make in
            make.height.equalTo(UiConstants.actionStackHeight)
            make.leading.equalToSuperview().inset(UiConstants.contentInset)
            make.top.equalTo(postImage.snp.bottom).offset(UiConstants.actionStackToPostImageOffset)
        }
        
        /// Likes Label - below action Stack
        contentView.addSubview(likesLabel)
        likesLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(UiConstants.contentInset)
            make.top.equalTo(actionsStack.snp.bottom).offset(UiConstants.likesLabelToActionStackOffset)
        }
        
        contentView.addSubview(bookMarkButton)
        bookMarkButton.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(UiConstants.bookMarkButtonToPostImageOffset)
            make.height.equalTo(UiConstants.actionStackHeight)
            make.trailing.equalToSuperview().inset(UiConstants.contentInset)
        }
        
        /// Comment label -  below likes label
        contentView.addSubview(commentLabel)
        commentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UiConstants.contentInset)
            make.top.equalTo(likesLabel.snp.bottom).offset(UiConstants.commentToLikeTopOffset)
            /// Finish cell -> make activeStack Buttons is active
            make.bottom.equalToSuperview().inset(UiConstants.contentInset)
        }
    }
    
    /// SetUp for comment label -> make user name font - bold
    func configureComment(with comment: CommentShortInfo) {
        let string  = comment.userName + " " + comment.commentText
        let attributeString = NSMutableAttributedString(string: string)
        let range = NSRange(location: .zero, length: comment.userName.count)
        attributeString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: UiConstants.commentLabelFont), range: range)
        commentLabel.attributedText = attributeString
    }
    
}

//MARK: Button Actions
private extension PostCell {
    
    /// Button actions
    func buttonsAction() {
        optionsButton.addTarget(self, action: #selector(optionsButtonAction), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(commentButtonAction), for: .touchUpInside)
        sharedButton.addTarget(self, action: #selector(sharedButtonAction), for: .touchUpInside)
        bookMarkButton.addTarget(self, action: #selector(bookMarkButtonAction), for: .touchUpInside)
    }
    
    @objc func optionsButtonAction(_ sender: UIButton) {
        print("[⚠️] Options button pressed")
    }
    
    @objc func likeButtonAction(_ sender: UIButton) {
        print("[⚠️] Like button pressed")
    }
    
    @objc func commentButtonAction(_ sender: UIButton) {
        print("[⚠️] Add comment pressed")
    }
    
    @objc func sharedButtonAction(_ sender: UIButton) {
        print("[⚠️] Shared button pressed")
    }
    
    @objc func bookMarkButtonAction(_ sender: UIButton) {
        print("[⚠️] Add to bookMark pressed")
    }
}
