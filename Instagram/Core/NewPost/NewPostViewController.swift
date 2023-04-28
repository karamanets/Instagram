//
//  NewPostViewController.swift
//  Instagram
//
//  Created by Alex Karamanets on 27.04.2023.
//

import UIKit

class NewPostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()

    }
}

//MARK: - Private methods
private extension NewPostViewController {
    
    func initialize() {
        view.backgroundColor = .systemGroupedBackground
        makeBarBottomIcon()
    }
    
    /// Bar bottom image title tag
    func makeBarBottomIcon() {
        let image = UIImage(systemName: "plus.square")?.withTintColor(UIColor(named: "barItems") ?? .systemGroupedBackground,
                                                                      renderingMode: .alwaysOriginal)
        
        let tabItem = UITabBarItem(title: "", image: image , tag: 2)
        self.tabBarItem = tabItem
    }
}
