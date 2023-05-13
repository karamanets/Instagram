//
//  SearchView.swift
//  Instagram
//
//  Created by Alex Karamanets on 10/05/2023.
//
import UIKit
import SnapKit

final class SearchViewController2: UIViewController {
    
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
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(SearchCollectionCell2.self, forCellWithReuseIdentifier: String(describing: SearchCollectionCell2.self))
        collectionView.register(HeaderReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: String(describing: HeaderReusableView.self))
       
        return collectionView
    }()
    
    /// DataServer
    private var items: [UIImage] = FakeDataService.shared.arrayImages
}

//MARK: - Private methods
private extension SearchViewController2 {
    
    func initialize() {
        ///View
        view.backgroundColor = UIColor.theme.background
        
        /// CollectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        
        /// Constraints
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: CollectionView DataSource
extension SearchViewController2: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                        String(describing: SearchCollectionCell2.self), for: indexPath) as! SearchCollectionCell2

        
        cell.configure(with: items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: String(describing: HeaderReusableView.self),
                for: indexPath) as! HeaderReusableView
            
            headerView.label.text = "Header"
            
            return headerView
        } else {
            
            return UICollectionReusableView()
        }
    }
}

//MARK: CollectionView Delegate FlowLayout
extension SearchViewController2: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.bounds.width / 3.06
        
        let height = view.bounds.height / 6.8
        
        return CGSize(width: width, height: height)
    }
}


//MARK: TextField
class HeaderReusableView: UICollectionReusableView {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
