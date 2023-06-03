//
//  Test.swift
//  Instagram
//
//  Created by Alex Karamanets on 01/06/2023.
//

import UIKit
import SnapKit

class Test: UIViewController {

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: Private Property
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.showsVerticalScrollIndicator = false
        view.separatorColor = UIColor.theme.background
        view.backgroundColor = UIColor.theme.background
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = false
        ///Register cells
        view.register(ProfileDiscoverSetCell.self, forCellReuseIdentifier: String(describing: ProfileDiscoverSetCell.self))

        return view
    }()
    
    ///DataService
    let dataService = FakeDataService.shared
}

//MARK: - Private methods
private extension Test {
    
    func initialize() {

        ///Elements
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: TableView DataSource
extension Test: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileDiscoverSetCell.self),
                                                 for: indexPath) as! ProfileDiscoverSetCell
        
        cell.configure(with: dataService.discoverUsers)
        
        return cell
    }
}

//MARK: TableView Delegate
extension Test: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 230
 
    }
}
