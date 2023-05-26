//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Alex Karamanets on 27.04.2023.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {

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
        view.register(ProfileTableViewHeader.self, forHeaderFooterViewReuseIdentifier: String(describing: ProfileTableViewHeader.self))
        ///Register cells
        view.register(ProfileStoriesSetCells.self, forCellReuseIdentifier: String(describing: ProfileStoriesSetCells.self))
        
        return view
    }()
    
    ///DataService
    let dataService = FakeDataService.shared
    
    var showStorySize: CGFloat = 120
}

//MARK: - Private methods
private extension ProfileViewController {
    
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
private extension ProfileViewController {
    
    /// Bar bottom image title tag
    func makeBarBottomIcon() {
        
        let size = CGSize(width: UiConstants.barItemSize, height: UiConstants.barItemSize)
        
        let radius = size.width / 2
        
        let image = dataService.userImage?
            .imageResized(to: size)
            .withCorner(radius: radius)?
            .withRenderingMode(.alwaysOriginal)
            
        let tabItem = UITabBarItem(title: "", image: image , tag: 4)
        self.tabBarItem = tabItem
    }
    
    /// Bar Button left
    func makeLeftBarButtonItem() -> [UIBarButtonItem] {
        
        let user = dataService.userName
        
        /// Add logo mage
        let userName = UIBarButtonItem(title: user,
                                       style: .done,
                                       target: self,
                                       action: #selector(userNameAction))
        /// Add bar button
        let addAccount = UIBarButtonItem(image: UIImage(systemName: "chevron.down"),
                                         style: .done,
                                         target: self,
                                         action: #selector(settingsButtonAction))
        
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
    
    /// Right Bar Button Actions
    @objc func createButtonAction() {
        print("[⚠️] Created button pressed")
    }
    @objc func settingsButtonAction() {
        print("[⚠️] Settings button pressed")
        updateSize()
    }
    
    /// Left Bar Button Actions
    @objc func userNameAction() {
        print("[⚠️] About account")
    }
    @objc func addAccountAction() {
        print("[⚠️] Change Account button pressed")
    }
    
}

//MARK: TableView DataSource
extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileStoriesSetCells.self),
                                                 for: indexPath) as! ProfileStoriesSetCells
        
        cell.configure(with: dataService.arrayImages)
        
        return cell
    }
}

//MARK: TableView Delegate
extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileTableViewHeader.self))
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.bounds.height / 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return showStorySize
           } else {
               return UITableView.automaticDimension
           }
 
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
               return showStorySize
           } else {
               return UITableView.automaticDimension
           }
    }
}


