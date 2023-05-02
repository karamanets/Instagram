//
//  NewPostCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 01/05/2023.
//

import UIKit
import SnapKit

class NewPostCell: UITableViewCell {
    
    //MARK: Public
    func configure(with image: UIImage) {
        
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
        static let contentInset: CGFloat = 12
    }
    
    //MARK: Private Property

    
}

//MARK: - Private methods
private extension NewPostCell {
    
    func initialize() {
        
        backgroundColor = .clear
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        

      
        

        
    }
}

class TextLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(withTextAlignment alignment: NSTextAlignment, andFont font: UIFont, andColor color: UIColor = .label, numberOfLines: Int = 1){
        self.init(frame: .zero)
        self.textAlignment = alignment
        self.font = font
        self.textColor = color
        self.numberOfLines = numberOfLines
    }

    private func configure() {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.85
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        setContentCompressionResistancePriority(.required, for: .vertical)
    }
}
