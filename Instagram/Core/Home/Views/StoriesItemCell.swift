//
//  StoriesItemCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 19.04.2023.
//

//MARK: User cell image and user name

import UIKit
import SnapKit

final class StoriesItemCell: UICollectionViewCell {
    
    //MARK: Public
    func configure(with info: StoriesItemCellInfo) { /// use one item from array of StoriesCellInfo
        imageView.image = info.image
        userLabel.text = info.userName
        addButton.isHidden = !info.isAddButtonVisible
        circleImage.isHidden = !info.isNewStory
        //print(info)
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private constants
    private enum UIConstants {
        static let imageSize: CGFloat = 80
        static let imageInset: CGFloat = 6
        static let labelOffset: CGFloat = 6
        static let userTextFont: CGFloat = 10
        static let buttonSize: CGFloat = 27
        static let circleImageSize: CGFloat = 92
        static let buttonInset: CGFloat = -3
        static let buttonBorderWidth: CGFloat = 3
    }
    
    //MARK: Private property
    private var imageView: UIImageView = {
       let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = UIConstants.imageSize / 2
        return view
    }()
    
    private var circleImage: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "LogoCircle")
        return view
    }()
    
    private var userLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIConstants.userTextFont)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "LogoPlus")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = UIConstants.buttonSize / 2
        button.layer.borderWidth = UIConstants.buttonBorderWidth
        button.layer.borderColor = UIColor.theme.background.cgColor
        button.addTarget(self, action: #selector(AddButtonAction), for: .touchUpInside)
        return button
    }()
}

//MARK: Private methods
private extension StoriesItemCell {
    
    func initialize() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(UIConstants.imageInset)
            make.width.height.equalTo(UIConstants.imageSize)
        }
        
        contentView.addSubview(userLabel)
        userLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(UIConstants.labelOffset)
            make.centerX.equalTo(imageView.snp.centerX)
        }
        
        contentView.addSubview(circleImage)
        circleImage.snp.makeConstraints { make in
            make.center.equalTo(imageView.snp.center)
            make.size.equalTo(UIConstants.circleImageSize)
        }
        
        contentView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(imageView).inset(UIConstants.buttonInset)
            make.size.equalTo(UIConstants.buttonSize)
        }
    }
    
    @objc func AddButtonAction(_ sender: UIButton) {
        print("[⚠️] Add new stories button pressed")
    }
}
