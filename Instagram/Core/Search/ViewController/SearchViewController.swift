//
//  SearchViewController.swift
//  Instagram
//
//  Created by Alex Karamanets on 27.04.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: Private
    private let dataService = FakeDataService()
    private let text: UITextField = {
        let text = UITextField()
        text.borderStyle = .roundedRect
        text.font = UIFont.systemFont(ofSize: 22, weight: .light, width: .standard)
        text.placeholder = "Search"
        text.clearButtonMode = .always
        text.keyboardType = .asciiCapable
        text.enablesReturnKeyAutomatically = true
        text.spellCheckingType = .yes
        text.smartInsertDeleteType = .yes
        text.tintColor = UIColor(named: "textFieldIcon")
        text.setIcon(UIImage(systemName: "magnifyingglass")!)
        return text
    }()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: String(describing: SearchCell.self))
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return collectionView
    }()
}

//MARK: - Private methods
private extension SearchViewController {
    func initialize() {
        /// View
        view.backgroundColor = UIColor(named: "customBackground")
        
        /// Elements
        makeBarBottomIcon()
        setUpTextField()
        setUpCollectionView()

        /// Bar bottom image title tag
        func makeBarBottomIcon() {
            let image = UIImage(systemName: "magnifyingglass")?.withTintColor(UIColor(named: "barItems") ?? .systemGroupedBackground,
                                                                              renderingMode: .alwaysOriginal)
            let tabItem = UITabBarItem(title: "", image: image , tag: 1)
            self.tabBarItem = tabItem
        }
    }
}

//MARK: SetUp TextField
private extension SearchViewController {
    
    func setUpTextField() {
        text.delegate = self
        view.addSubview(text)
        text.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

//MARK: setUp CollectionView
private extension SearchViewController {
    
    func setUpCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(text.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//MARK: TextField Delegate
extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
    
}
    
//MARK: CollectionView Delegate FlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView:
                        UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width / 3 - 10, height: view.frame.height / 5 - 50)
    }
}

//MARK: CollectionView DataSource
extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataService.arrayFakeDataImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SearchCell.self), for: indexPath) as! SearchCell
        
        cell.configure(with: dataService.arrayFakeDataImages[indexPath.item])
        
        return cell
    }
}


