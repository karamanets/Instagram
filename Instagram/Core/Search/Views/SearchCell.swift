//
//  SearchCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 29.04.2023.
//

import UIKit
import SnapKit

class SearchCell: UICollectionViewCell {
    
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
    
    //MARK: Private
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.layer.shadowColor = UIColor(named: "shadowImagesSearch")?.cgColor
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3
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
private extension SearchCell {
    func initialize() {

        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(icon)
        icon.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.trailing.equalTo(-10)
            make.size.equalTo(20)
        }
    }
}

