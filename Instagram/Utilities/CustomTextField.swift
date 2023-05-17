//
//  CustomTextField.swift
//  Instagram
//
//  Created by Alex Karamanets on 15/05/2023.
//

import UIKit

final class CustomTextField: UITextField {
    
    //MARK: Public
    public let insets: UIEdgeInsets
    public let placeholderText: String
    
    //MARK: Init
    init(insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40), placeholderText: String = "Search") {
        self.insets = insets
        self.placeholderText = placeholderText
        super.init(frame: .zero)
        
        placeholder = placeholderText
        backgroundColor = UIColor.theme.searchTextFieldBackground
        layer.borderColor = UIColor.theme.iconStroke.cgColor
        layer.cornerRadius = 15
        layer.borderWidth = 0.3
        font = UIFont.systemFont(ofSize: 22, weight: .light, width: .standard)
        tintColor = UIColor.theme.icons
        clearButtonMode = .always
        spellCheckingType = .yes
        smartInsertDeleteType = .yes
        enablesReturnKeyAutomatically = true
        keyboardType = .asciiCapable
        leftView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Override Methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        
        /// point = 1/4 from height of textField
        let point = CGPoint(x: bounds.height / 4, y: bounds.height / 4)
        
        let iconSize = CGSize(width: bounds.height / 2, height: bounds.height / 2)
        
        return CGRect(origin: point, size: iconSize)
    }
}
