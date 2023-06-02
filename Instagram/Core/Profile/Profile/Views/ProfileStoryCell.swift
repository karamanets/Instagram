//
//  ProfileStoryCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 29/05/2023.
//

import UIKit
import SnapKit

final class ProfileStoryCell: UICollectionViewCell {
    
    //MARK: Public
    public func configure(with info: ProfileStoryModel) {
        imageView.image = UIImage(named: info.imageName)
    }
    
    //MARK: UiConstants
    fileprivate enum UiConstants {
        static let imageInset: CGFloat = 8
        static let headerLeadingInset: CGFloat = 8
        static let labelNewSize: CGFloat = 15
        static let headerStoryOffSet: CGFloat = 8
        static let ofSetHeaderLabel: CGFloat = 3
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
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = cornerRadiusImage
        return view
    }()
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            }
        }
    }

    var cornerRadiusImage: CGFloat = .zero
}

//MARK: - Private Methods
private extension ProfileStoryCell {
    
    func initialize() {
        /// Size for image cell
        let imageSize = bounds.width - UiConstants.imageInset
        cornerRadiusImage = imageSize / 2
    
        ///Elements
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(UiConstants.imageInset)
            make.size.equalTo(imageSize)
        }
    }
    
}

//MARK: HeaderView Add Button
final class HeaderStoryButton: UICollectionReusableView {
    
    //MARK: Fileprivate
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "storyImage")?
            .withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.text = "New"
        view.font = UIFont.systemFont(ofSize: ProfileStoryCell.UiConstants.labelNewSize, weight: .medium)
        view.textColor = UIColor.theme.icons
        view.textAlignment = .center
        return view
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageSize = bounds.width - ProfileStoryCell.UiConstants.headerLeadingInset
        
        addSubview(button)
        button.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(ProfileStoryCell.UiConstants.headerLeadingInset)
            make.top.equalToSuperview().offset(ProfileStoryCell.UiConstants.headerStoryOffSet)
            make.size.equalTo(imageSize)
        }
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(ProfileStoryCell.UiConstants.ofSetHeaderLabel)
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
