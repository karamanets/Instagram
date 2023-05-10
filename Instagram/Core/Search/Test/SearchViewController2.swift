//
//  SearchViewController2.swift
//  Instagram
//
//  Created by Alex Karamanets on 10/05/2023.
//

import UIKit
import SnapKit

class SearchViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(SearchTableCell.self, forCellReuseIdentifier: String(describing: SearchTableCell.self))
        return table
    }()
    
    var imagesArray = [ UIImage(named: "image1")!, UIImage(named: "image2")!, UIImage(named: "image3")!, UIImage(named: "image4")! ]
    var imagesArray2 = [ UIImage(systemName: "person")!, UIImage(systemName: "person")!, UIImage(systemName: "person")!, UIImage(systemName: "person")! ]
}

//MARK: Private Methods
private extension SearchViewController2 {
    
    func initialize() {
        ///View
        view.backgroundColor = .red
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SearchViewController2: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchTableCell.self), for: indexPath) as! SearchTableCell
        
        cell.configure(with: imagesArray2)
        
        return cell
    }
    
    
}

