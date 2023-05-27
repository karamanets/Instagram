//
//  NewPostCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 01/05/2023.
//

import UIKit
import SnapKit

class NewPostCell: UICollectionViewCell {
    
    //MARK: Public
    func configure(with image: String) {
        imageView.image = UIImage(named: image)
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Constants
    private enum UiConstants {
        static let contentInset: CGFloat = 12
    }
    
    //MARK: Private Property
    private let imageView: UIImageView = {
       let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        return view
    }()
    
    private let shadow = UIView()
}

//MARK: - Private methods
private extension NewPostCell {
    
    func initialize() {
        /// View
        backgroundColor = UIColor.theme.background
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 1
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = .zero
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
}
