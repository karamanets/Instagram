//
//  NewPostViewController.swift
//  Instagram
//
//  Created by Alex Karamanets on 27.04.2023.
//

import UIKit
import SnapKit

class NewPostViewController: UIViewController {

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: Constants
    private enum UIConstants {
        
    }
    
    //MARK: Private property
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.showsVerticalScrollIndicator = false
        table.separatorColor = .clear
        //table.estimatedRowHeight = 100
        //table.sectionHeaderHeight = 40
        //table.rowHeight = UITableView.automaticDimension
        //table.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        table.backgroundColor = .clear
        table.register(NewPostCell.self, forCellReuseIdentifier: String(describing: NewPostCell.self))
        return table
    }()
}

//MARK: - Private methods
private extension NewPostViewController {
    
    func initialize() {
        /// Background view
        view.backgroundColor = UIColor(named: "customBackground")
        /// Navigation Elements
        navigationItem.leftBarButtonItems = makeLeftBarItem()
        navigationItem.rightBarButtonItem = makeRightBarItem()
        /// Methods
        makeTabBarIcon()
        
        /// Elements and Constraint
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    /// Bar bottom image title tag
    func makeTabBarIcon() {
        let image = UIImage(systemName: "plus.square")?.withTintColor(UIColor(named: "barItems") ?? .systemGroupedBackground,
                                                                      renderingMode: .alwaysOriginal)
        
        let tabItem = UITabBarItem(title: "", image: image , tag: 2)
        self.tabBarItem = tabItem
    }
}

//MARK: Bar Items
private extension NewPostViewController {
    
    func makeLeftBarItem() -> [UIBarButtonItem] {
        /// Dismiss left Button
        let dismissButtonImage = UIImage(systemName: "xmark")?.withTintColor(UIColor(named: "barItems") ?? .systemGroupedBackground,
                                                                             renderingMode: .alwaysOriginal)
        let dismissButton = UIBarButtonItem(image: dismissButtonImage, style: .plain, target: self, action: #selector(dismissButtonAction))
        
        /// Label
        let label = UILabel()
        label.text = "New Post"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        let navigationLabel = UIBarButtonItem(customView: label)
        
        
        return [dismissButton, navigationLabel]
    }
    
    func makeRightBarItem() -> UIBarButtonItem {
        /// Next Button
        let nextButtonImage = UIImage(systemName: "arrow.forward")?.withTintColor(UIColor(named: "barItems") ?? .systemGroupedBackground,
                                                                                  renderingMode: .alwaysOriginal)
        let nextButton = UIBarButtonItem(image: nextButtonImage, style: .plain, target: self, action: #selector(nextButtonAction))
        
        return nextButton
    }
}

//MARK: Button Actions
private extension NewPostViewController {
    
    @objc func dismissButtonAction(_ sender: UIButton) {
        print("Add new Post")
    }
    
    @objc func nextButtonAction(_ sender: UIButton) {
        print("Next")
    }
}

//MARK: TableView DataSource
extension NewPostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewPostCell.self), for: indexPath) as! NewPostCell
        
        //let cell = UITableViewCell()
        
        return cell
    }
    
    
}

//MARK: TableView Delegate
extension NewPostViewController: UITableViewDelegate {
    
}

