//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Alex Karamanets on 27.04.2023.
//

import UIKit
import SnapKit

//🔥 Incorrect Example

class ProfileViewController_2: UIViewController {

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: UiConstants
    private enum UiConstants {
        static let barItemSize:CGFloat = 30
    }
    
    //MARK: Private Property
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.showsVerticalScrollIndicator = false
        view.separatorColor = UIColor.clear
        view.backgroundColor = UIColor.theme.background
        ///Register header
        view.register(ProfileTableViewHeader_2.self, forHeaderFooterViewReuseIdentifier: String(describing: ProfileTableViewHeader_2.self))
        ///Register cells
        view.register(ProfileStoriesSetCells_2.self, forCellReuseIdentifier: String(describing: ProfileStoriesSetCells_2.self))
        view.register(ProfileGallerySetCells_2.self, forCellReuseIdentifier: String(describing: ProfileGallerySetCells_2.self))
        return view
    }()
    
    ///DataService
    let dataService = FakeDataService.shared
    
    var showStorySize: CGFloat = 120
}

//MARK: - Private methods
private extension ProfileViewController_2 {
    
    func initialize() {
        ///View
        view.backgroundColor = UIColor.theme.background
        navigationController?.navigationBar.tintColor = UIColor.theme.icons
        
        navigationItem.leftBarButtonItems = makeLeftBarButtonItem()
        navigationItem.rightBarButtonItems = makeRightBarButtonItem()
        
        ///Methods
        makeBarBottomIcon()
        
        ///Elements
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateSize() {
        if showStorySize == 0 {
            self.tableView.beginUpdates()
            self.showStorySize = 120
            self.tableView.endUpdates()
        } else {
            self.tableView.beginUpdates()
            self.showStorySize = 0
            self.tableView.endUpdates()
        }
    }
}

//MARK: Bar Items
private extension ProfileViewController_2 {
    
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
    
    /// Bar Button left
    func makeLeftBarButtonItem() -> [UIBarButtonItem] {
        
        let user = dataService.userModel?.name
        
        /// Add logo mage
        let userName = UIBarButtonItem(title: user,
                                       style: .done,
                                       target: self,
                                       action: #selector(userNameAction))
        /// Add bar button
        let addAccount = UIBarButtonItem(image: UIImage(systemName: "chevron.down"),
                                         style: .done,
                                         target: self,
                                         action: #selector(addAccountAction))
        /// return logo and button
        return [userName, addAccount]
    }
    
    /// Bar Buttons right
    func makeRightBarButtonItem() -> [UIBarButtonItem] {
        /// Two button
        let createButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app"),
                                               style: .plain,
                                               target: self,
                                               action: #selector(createButtonAction))
        
        let settingsButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(settingsButtonAction))
        return [settingsButtonItem, createButtonItem]
    }
    
    /// Left Bar Button Actions
    @objc func userNameAction() {
        print("[⚠️] About account")
    }
    @objc func addAccountAction() {
        print("[⚠️] Change Account button pressed")
    }
    
    /// Right Bar Button Actions
    @objc func createButtonAction() {
        print("[⚠️] Created button pressed")
    }
    @objc func settingsButtonAction() {
        print("[⚠️] Settings button pressed")
        updateSize()
    }
    
}

//MARK: TableView DataSource
extension ProfileViewController_2: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.profileType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = dataService.profileType[indexPath.row]

        switch item {

        case .stories(let story):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileStoriesSetCells_2.self),
                                                     for: indexPath) as! ProfileStoriesSetCells_2
            cell.configure(with: story)
            return cell

        case .gallery(let gallery):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileGallerySetCells_2.self),
                                                     for: indexPath) as! ProfileGallerySetCells_2
            cell.configure(with: gallery)
            
            return cell
        }
    }
}

//MARK: TableView Delegate
extension ProfileViewController_2: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileTableViewHeader_2.self))
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.bounds.height / 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return showStorySize
           } else {
               return view.bounds.height
           }
 
    }
}



