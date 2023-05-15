//
//  HeaderView.swift
//  Instagram
//
//  Created by Alex Karamanets on 15/05/2023.
//

import UIKit

//MARK: TextField
class HeaderView: UICollectionReusableView {
    
    //MARK: Constants
    private enum UIConstants {
        static let inset: CGFloat = 8
        static let textFieldHeight: CGFloat = 50
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(UIConstants.inset)
            make.height.equalTo(UIConstants.textFieldHeight)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Property
    private let textField: UITextField = {
        let text = CustomTextField()
        return text
    }()
}

//MARK: TextField Delegate - add custom delegate
extension HeaderView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}
