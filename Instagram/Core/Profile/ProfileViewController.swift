//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Alex Karamanets on 27.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

//MARK: - Private methods
private extension ProfileViewController {
    
    func initialize() {
        ///View
        view.backgroundColor = .systemGroupedBackground
        ///Methods
        makeBarBottomIcon()
        
        ///Elements
        
    }
    
    /// Bar bottom image title tag
    func makeBarBottomIcon() {
        let image = UIImage(systemName: "person")?.withTintColor(UIColor.theme.icons, renderingMode: .alwaysOriginal)
        let tabItem = UITabBarItem(title: "", image: image , tag: 2)
        self.tabBarItem = tabItem
    }
}
