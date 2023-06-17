//
//  ProfileViewControllerHosting.swift
//  Instagram
//
//  Created by Alex Karamanets on 17/06/2023.
//

import UIKit
import SwiftUI

class ProfileViewControllerHosting: UIViewController {

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: UiConstants
    private enum UiConstants {
        static let barItemSize:CGFloat = 30
    }
    
    //
    ///DataService
    private let dataService = FakeDataService.shared
}

//MARK: - Private methods
private extension ProfileViewControllerHosting {

    func initialize() {
        ///Methods
        makeBarBottomIcon()
    }
    
    /// Bar bottom image title tag
    func makeBarBottomIcon() {

        let size = CGSize(width: UiConstants.barItemSize, height: UiConstants.barItemSize)

        let radius = size.width / 2
        
        let image = UIImage(named: dataService.userModel?.userImage ?? "")?
            .imageResized(to: size)
            .withCorner(radius: radius)?
            .withRenderingMode(.alwaysOriginal)

        let tabItem = UITabBarItem(title: "", image: image , tag: 4)
        self.tabBarItem = tabItem
    }

}
