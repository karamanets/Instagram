//
//  SearchCollectionCell2.swift
//  Instagram
//
//  Created by Alex Karamanets on 13/05/2023.
//

import UIKit

class SearchCollectionCell2: UICollectionViewCell {
    
    //MARK: Public
    func configure(with image: UIImage) {
        self.imageView.image = image
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    }
    
    //MARK: Private property
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        return view
    }()
    
    private let icon: UIImageView = {
        let icon = UIImage(systemName: "photo.fill.on.rectangle.fill")?.withRenderingMode(.alwaysTemplate)
        let view = UIImageView(image: icon)
        view.tintColor = .white
        return view
    }()

}

//MARK: - Private methods
private extension SearchCollectionCell2 {
    func initialize() {
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 1
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = .zero
    
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.top.equalTo(UIConstants.iconTop)
            make.trailing.equalTo(UIConstants.iconTrailing)
            make.size.equalTo(UIConstants.iconSize)
        }
    }
}

