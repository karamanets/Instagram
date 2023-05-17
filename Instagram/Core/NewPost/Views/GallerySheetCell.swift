//
//  GallerySheetCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 05/05/2023.
//

import UIKit
import SnapKit

class GallerySheetCell: UITableViewCell {
    
    //MARK: Public
    public func configure(with text: String) {
        labelItem.text = text
    }
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private property
    private let labelItem: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.backgroundColor = UIColor.theme.background
        label.font = UIFont.preferredFont(forTextStyle: .title1, compatibleWith: .current)
        return label
    }()
    
}

//MARK: Private methods
private extension GallerySheetCell {
    
    func initialize() {
        
        contentView.backgroundColor = UIColor.theme.background
        
        contentView.addSubview(labelItem)
        labelItem.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
    }
}
