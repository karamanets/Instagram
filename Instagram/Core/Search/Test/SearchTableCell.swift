//
//  SearchView.swift
//  Instagram
//
//  Created by Alex Karamanets on 10/05/2023.
//
import UIKit
import SnapKit

final class SearchTableCell: UITableViewCell {
    
    //MARK: Public method
    func configure(with images: [UIImage]) {
        self.items = images
        collectionView.reloadData()
        //print(info)
    }
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .null, collectionViewLayout: layout)
        
        collectionView.register(SearchCollectionCell.self, forCellWithReuseIdentifier: String(describing: SearchCollectionCell.self))
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()
    
    /// typealias name (array)
    private var items: [UIImage] = []
}

//MARK: - Private methods
private extension SearchTableCell {
    
    func initialize() {
        ///View
        contentView.backgroundColor = UIColor.theme.background
        /// CollectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        
        /// Constraints
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(contentView.bounds.height * 2.6)
        }
    }
}

//MARK: CollectionView DataSource
extension SearchTableCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                        String(describing: SearchCollectionCell.self), for: indexPath) as! SearchCollectionCell
        cell.configure(with: items[indexPath.item])
        return cell
    }
}

//MARK: CollectionView Delegate FlowLayout
extension SearchTableCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width / 5
        
        let height = collectionView.bounds.height - 16
        
        return CGSize(width: width, height: height)
    }
}











//=====================================

final class SearchTableCell1: UITableViewCell {
    
    //MARK: Public
    func configure(with images: [UIImage]) {
        //self.imagesArray = images
        collectionView.reloadData()
    }
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private property
    private let textField: UITextField = {
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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCollectionCell.self, forCellWithReuseIdentifier: String(describing: SearchCollectionCell.self))
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        //collectionView.backgroundColor = .red
        return collectionView
    }()
    
    //MARK: DataService
    private let dataService = FakeDataService()
    
    var imagesArray = [ UIImage(named: "image1")!, UIImage(named: "image2")!, UIImage(named: "image3")!, UIImage(named: "image4")! ]
}

//MARK: Private property
private extension SearchTableCell1 {
    
    func initialize() {
        /// View
        contentView.backgroundColor = UIColor.theme.background
        
        /// Elements
        contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(contentView.bounds.height * 2.6)
        }
    }
}
    
//MARK: CollectionView Delegate FlowLayout
extension SearchTableCell1: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView:
                        UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = contentView.bounds.width / 3.075
        
        let height = contentView.bounds.height / 6.16
        
        return CGSize(width: width, height: height)
    }
}

//MARK: CollectionView DataSource
extension SearchTableCell1: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SearchCollectionCell.self), for: indexPath) as! SearchCollectionCell
        
        cell.configure(with: imagesArray[indexPath.item])
        
        return cell
    }
}

