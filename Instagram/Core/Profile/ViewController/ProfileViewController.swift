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
}

//MARK: - Private methods
private extension ProfileViewController {
    
    func initialize() {
        ///View
        view.backgroundColor = UIColor.theme.background
        
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
}
