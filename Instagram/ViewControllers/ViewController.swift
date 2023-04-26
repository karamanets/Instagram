//
//  FeedViewController.swift
//  Instagram
//
//  Created by Alex Karamanets on 19.04.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        /// Elements
        setUpBarButtonItems()
        setUpTableView()
    }
    
    //MARK: Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        items = dataService.arrayFakeData
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private properties
    private let dataService = FakeDataService()
    
    private let tableView = UITableView()
    //MARK: DataService
    private var items: [FeedItemType] = []

}

//MARK: - Bar Button Items
private extension ViewController {
    
    func setUpBarButtonItems() {
        /// Make icon left item black
        navigationController?.navigationBar.tintColor = .black
        /// Add Bar Items
        navigationItem.leftBarButtonItems = makeLeftBarButtonItem()
        navigationItem.rightBarButtonItems = makeRightBarButtonItem()
    }
    
    /// Bar Button left
    func makeLeftBarButtonItem() -> [UIBarButtonItem] {
        /// Add logo mage
        let logoBarButtonItem = UIBarButtonItem(customView: LogoView())
        /// Add bar button
        let dropDownButtonItem = UIBarButtonItem(title: nil , image: UIImage(systemName: "chevron.down"), target: self, action: nil, menu: makeDropDownMenu())
        
        /// return logo and button
        return [logoBarButtonItem, dropDownButtonItem]
    }
    
    /// Bar Buttons right
    func makeRightBarButtonItem() -> [UIBarButtonItem] {
        /// Two button
        let addBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(addBarAction))
        let directButtonItem = UIBarButtonItem(image: UIImage(systemName: "paperplane"), style: .plain, target: self, action: #selector(directButtonAction))
        
        return [directButtonItem, addBarButtonItem]
    }
    
    /// Right Bar Button Actions
    @objc func addBarAction() {
        print("Add some")
    }
    @objc func directButtonAction() {
        print("Hello")
    }
    
    /// Bar Item
    func makeDropDownMenu() -> UIMenu {
        
        let subscriberItem = UIAction(title: "Subscribers", image: UIImage(systemName: "person.2")) { _ in }
        
        let favoriteItem = UIAction(title: "Favorite", image: UIImage(systemName: "star")) { _ in }
        
        return UIMenu(children: [subscriberItem, favoriteItem])
    }
}

//MARK: - TableView
private extension ViewController {
    
    func setUpTableView() {
        view.addSubview(tableView)
        /// Constraints
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.dataSource = self
        tableView.separatorColor = .clear
        /// Register  cell
        tableView.register(StoriesSetCell.self, forCellReuseIdentifier: String(describing: StoriesSetCell.self))
        tableView.register(PostCell.self, forCellReuseIdentifier: String(describing: PostCell.self))
    }
}

//MARK: TableView Data Source
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        switch item {
        case .stories(let info):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StoriesSetCell.self), for: indexPath) as! StoriesSetCell
            cell.configure(with: info)
            return cell
            
        case .post(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostCell.self), for: indexPath) as! PostCell
            cell.configure(with: post)
            return cell
        }
    }
}
