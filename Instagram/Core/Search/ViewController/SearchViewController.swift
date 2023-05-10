//
//  SearchViewController.swift
//  Instagram
//
//  Created by Alex Karamanets on 27.04.2023.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: Private Property
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
        text.tintColor = UIColor.theme.textFieldBackground
        text.setIcon(UIImage(systemName: "magnifyingglass")!)
        return text
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCollectionCell.self, forCellWithReuseIdentifier: String(describing: SearchCollectionCell.self))
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        return collectionView
    }()
    
    //MARK: DataService
    private let dataService = FakeDataService()
}

//MARK: - Private methods
private extension SearchViewController {
    
    func initialize() {
        /// View
        view.backgroundColor = UIColor.theme.background
        
        /// Methods
        makeBarBottomIcon()
        
        /// Elements Constraints
        text.delegate = self
        view.addSubview(text)
        text.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(text.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    /// Bar bottom image title tag
    func makeBarBottomIcon() {
        let image = UIImage(systemName: "magnifyingglass")?.withTintColor(UIColor.theme.icons, renderingMode: .alwaysOriginal)
        let tabItem = UITabBarItem(title: "", image: image , tag: 1)
        self.tabBarItem = tabItem
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
        
        let width = view.bounds.width / 3.06
        
        let height = view.bounds.height / 6.8
        
        return CGSize(width: width, height: height)
    }
}

//MARK: CollectionView DataSource
extension SearchViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataService.arrayFakeDataImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                        String(describing: SearchCollectionCell.self), for: indexPath) as! SearchCollectionCell

        cell.configure(with: dataService.arrayFakeDataImages[indexPath.item])

        return cell
    }
}

//MARK: CollectionView Delegate
extension SearchViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let index = indexPath.item

        print("[⚠️] Selected image number: \(index)")
    }
}
