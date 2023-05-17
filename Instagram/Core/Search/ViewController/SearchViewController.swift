//
//  SearchView.swift
//  Instagram
//
//  Created by Alex Karamanets on 10/05/2023.
//
import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: Private properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(SearchCollectionCell.self,
                                forCellWithReuseIdentifier: String(describing: SearchCollectionCell.self))
        
        collectionView.register(HeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: String(describing: HeaderView.self))
       
        return collectionView
    }()
    
    /// DataServer
    private var items: [UIImage] = FakeDataService.shared.arrayImages
}

//MARK: - Private methods
private extension SearchViewController {
    
    func initialize() {
        ///View
        view.backgroundColor = UIColor.theme.background
        
        ///Methods
        makeBarBottomIcon()
        
        /// CollectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        
        /// Constraints
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
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

//MARK: CollectionView DataSource
extension SearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                        String(describing: SearchCollectionCell.self), for: indexPath) as! SearchCollectionCell

        
        cell.configure(with: items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath ) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     withReuseIdentifier: String(describing: HeaderView.self),
                                                                     for: indexPath) as! HeaderView
        header.textField.delegate = self
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let width = view.frame.width
        let height = view.frame.width / 6
        
        return CGSize(width: width, height: height)
    }
}

//MARK: CollectionView Delegate FlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.bounds.width / 3.06
        
        let height = view.bounds.height / 6.8
        
        return CGSize(width: width, height: height)
    }
}

//MARK: CollectionView Delegate
extension SearchViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let index = indexPath.item

        print("[⚠️] Selected image number: \(index)")
    }
}

//MARK: TextField Delegate
extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        /// passed data
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}

//MARK: Header TextField
final class HeaderView: UICollectionReusableView {
    
    //MARK: Fileprivate
    fileprivate let textField: UITextField = {
        let text = CustomTextField()
        return text
    }()
    
    //MARK: Constants
    private enum UIConstants {
        static let inset: CGFloat = 8
        static let textFieldHeight: CGFloat = 50
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(UIConstants.inset)
            make.height.equalTo(UIConstants.textFieldHeight)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
