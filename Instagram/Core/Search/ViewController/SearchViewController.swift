//
//  SearchViewController.swift
//  Instagram
//
//  Created by Alex Karamanets on 27.04.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: Private property
    private let text: UITextField = {
        let text = UITextField()
        text.borderStyle = .roundedRect
        text.font = UIFont.systemFont(ofSize: 22, weight: .light, width: .standard)
        text.placeholder = "Search"
        text.clearButtonMode = .always
        text.keyboardType = .asciiCapable
        text.enablesReturnKeyAutomatically = true
        text.spellCheckingType = .yes
        text.smartInsertDeleteType = .yes
        text.tintColor = UIColor(named: "textFieldIcon")
        text.setIcon(UIImage(systemName: "magnifyingglass")!)
        return text
    }()

}

//MARK: - Private methods
private extension SearchViewController {
    
    func initialize() {
        view.backgroundColor = .systemGroupedBackground
        makeBarBottomIcon()
        
        text.delegate = self
        view.addSubview(text)
        text.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    /// Bar bottom image title tag
    func makeBarBottomIcon() {
        let image = UIImage(systemName: "magnifyingglass")?.withTintColor(UIColor(named: "barItems") ?? .systemGroupedBackground,
                                                                          renderingMode: .alwaysOriginal)
        let tabItem = UITabBarItem(title: "", image: image , tag: 1)
        self.tabBarItem = tabItem
    }
}

//MARK: - TextField Delegate
extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
    
}
