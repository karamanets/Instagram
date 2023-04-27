//
//  SearchViewController.swift
//  Instagram
//
//  Created by Alex Karamanets on 27.04.2023.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

//MARK: - Private methods
private extension SearchViewController {
    
    func initialize() {
        view.backgroundColor = .systemGroupedBackground
        makeBarBottomIcon()
    }
    
    /// Bar bottom image title tag
    func makeBarBottomIcon() {
        let image = UIImage(systemName: "magnifyingglass")?.withTintColor(UIColor(named: "barItems") ?? .systemGroupedBackground,
                                                                          renderingMode: .alwaysOriginal)
        
        let tabItem = UITabBarItem(title: "", image: image , tag: 1)
        self.tabBarItem = tabItem
    }
}
