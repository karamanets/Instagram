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
    private enum UiConstants {
        static let imageInset: CGFloat = 8
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

    var cornerRadiusImage: CGFloat = 0
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
