//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Alex Karamanets on 27.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: UiConstants
    private enum UiConstants {
        static let barItemSize:CGFloat = 37
    }
    
    //MARK: Private Property
    
    ///DataService
    let dataService = FakeDataService.shared
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
        
        let size = CGSize(width: UiConstants.barItemSize, height: UiConstants.barItemSize)
        
        let radius = size.width / 2
        
        let image = dataService.userImage?.imageResized(to: size).withCorner(radius: radius)?.withRenderingMode(.alwaysOriginal)
        
        let tabItem = UITabBarItem(title: "", image: image , tag: 4)
        self.tabBarItem = tabItem
    }
}
