//
//  ReelsViewController.swift
//  Instagram
//
//  Created by Alex Karamanets on 27.04.2023.
//

import UIKit

class ReelsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

//MARK: - Private methods
private extension ReelsViewController {
    
    func initialize() {
        view.backgroundColor = .systemGroupedBackground
        makeBarBottomIcon()
    }
    
    /// Bar bottom image title tag
    func makeBarBottomIcon() {
        let image = UIImage(systemName: "play.rectangle.on.rectangle.fill")?.withTintColor(UIColor(named: "barItems") ?? .systemGroupedBackground,
                                                                                           renderingMode: .alwaysOriginal)
        
        let tabItem = UITabBarItem(title: "", image: image , tag: 2)
        self.tabBarItem = tabItem
    }
}
