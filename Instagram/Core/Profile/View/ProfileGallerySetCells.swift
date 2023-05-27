//
//  ProfileGallerySetCells.swift
//  Instagram
//
//  Created by Alex Karamanets on 27/05/2023.
//
//
import UIKit
import SnapKit

final class ProfileGallerySetCells: UITableViewCell {
    
    //MARK: Public
    public func configure(with info: ProfileGalleryModel) {
        self.image.image = UIImage(named: info.imageName)
    }
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Constants
    private enum UIConstants {
        static let iconTop: CGFloat = 10
        static let iconTrailing: CGFloat = -10
        static let iconSize: CGFloat = 20
        static let iconCornerRadius: CGFloat = 3
        static let shadowRadiusCell: CGFloat = 1
        static let shadowOpacityCell: Float = 0.2
    }

    //MARK: Private property
    private let image: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = UIConstants.iconCornerRadius
        return view
    }()

    private let icon: UIImageView = {
        let icon = UIImage(systemName: "square.fill.on.square.fill")?
            .withRenderingMode(.alwaysTemplate)
        let view = UIImageView(image: icon)
        view.tintColor = .white
        return view
    }()

}

//MARK: - Private methods
private extension ProfileGallerySetCells {

    func initialize() {

//        contentView.layer.shadowColor = UIColor.black.cgColor
//        contentView.layer.shadowRadius = UIConstants.shadowRadiusCell
//        contentView.layer.shadowOpacity = UIConstants.shadowOpacityCell
//        contentView.layer.shadowOffset = .zero

        contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.size.equalTo(100)
        }

//        contentView.addSubview(icon)
//        icon.snp.makeConstraints { make in
//            make.top.equalTo(UIConstants.iconTop)
//            make.trailing.equalTo(UIConstants.iconTrailing)
//            make.size.equalTo(UIConstants.iconSize)
//        }
    }
}




