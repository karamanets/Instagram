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
    
    //MARK: Data Service
    
    
    //MARK: Private property
    private let mainImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "image2")
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    private lazy var galleryButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "chevron.down")?.withTintColor(UIColor(named: "barItems") ?? .systemGroupedBackground,
                                                                       renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.setTitle("Gallery", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(UIColor(named: "barItems"), for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        button.addTarget(self, action: #selector(galleryButtonAction), for: .touchUpInside)
        return button
    }()
    private let imageSelect: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(systemName: "person")
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var imagePhotoButton: UIImageView = {
        let view = UIImageView()
        let image = UIImage(systemName: "camera.circle.fill")?.withTintColor(UIColor(named: "barItems") ?? .systemGroupedBackground,
                                                                             renderingMode: .alwaysOriginal)
        view.image = image
        view.contentMode = .scaleAspectFit
        let imageWidth = NSLayoutConstraint(item: view,
                                            attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 35)
        let imageHeight = NSLayoutConstraint(item: view,
                                             attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 35)
        view.addConstraints([imageWidth, imageHeight])
        return view
    }()
    private let spacing: UIImageView = {
       let view = UIImageView()
        view.image = UIImage()
        view.contentMode = .scaleAspectFit
        return view
    }()
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
        
        /// Main Image
        view.addSubview(mainImage)
        mainImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 2.5)
        }
        
        /// Center HStack
        let HStackHeader = UIStackView(arrangedSubviews: [spacing, galleryButton, imageSelect, imagePhotoButton, spacing])
        HStackHeader.axis = .horizontal
        HStackHeader.alignment = .center
        HStackHeader.spacing = 10
        HStackHeader.backgroundColor = UIColor(named: "customBackground")
        HStackHeader.setCustomSpacing(20, after: galleryButton)
        HStackHeader.distribution = .fillProportionally
        HStackHeader.backgroundColor = .systemPink
        view.addSubview(HStackHeader)
        HStackHeader.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(50)
        }
        
        //galleryButton.addTarget(self, action: #selector(galleryButtonAction), for: .touchUpInside)
        
        /// TableView
        tableView.delegate = self
        tableView.dataSource = self
       // view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
//            make.top.equalTo(mainImage.snp.bottom)
//            make.leading.trailing.equalToSuperview()
//            make.bottom.equalToSuperview()
        }
    }
    
    /// Bar bottom image title tag
    func makeTabBarIcon() {
        let image = UIImage(systemName: "plus.square")?.withTintColor(UIColor(named: "barItems") ?? .systemGroupedBackground,
                                                                      renderingMode: .alwaysOriginal)
        
        let tabItem = UITabBarItem(title: "", image: image , tag: 2)
        self.tabBarItem = tabItem
    }
    
    /// Bar Item Left
    func makeLeftBarItem() -> [UIBarButtonItem] {
        /// Dismiss left Button
        let dismissButtonImage = UIImage(systemName: "xmark")?.withTintColor(UIColor(named: "barItems") ?? .systemGroupedBackground,
                                                                             renderingMode: .alwaysOriginal)
        let dismissButton = UIBarButtonItem(image: dismissButtonImage, style: .plain, target: self, action: #selector(dismissButtonAction))
        
        /// Label
        let label = UILabel()
        label.text = "New Post"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        let navigationLabel = UIBarButtonItem(customView: label)
        
        
        return [dismissButton, navigationLabel]
    }
    
    /// Bar Item Right
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
    
    @objc func galleryButtonAction(_ sender: UIButton) {
        print("galleryButton drop sheet")
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

