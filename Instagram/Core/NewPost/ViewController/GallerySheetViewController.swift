//
//  GallerySheet.swift
//  Instagram
//
//  Created by Alex Karamanets on 04/05/2023.
//

import UIKit
import SnapKit

protocol GallerySheetViewControllerDelegate {
    
    func didChange(_ string: String)
}

class GallerySheetViewController: UIViewController {
    
    //MARK: Public
    var delegateSheet: GallerySheetViewControllerDelegate?
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: Private property
    private lazy var dismissButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "xmark")
        config.baseForegroundColor = UIColor.theme.icons
        let button = UIButton(configuration: config, primaryAction: dismissButtonAction())
        return button
    }()
    
    private let topImage: UIImageView = {
        let view = UIImageView()
        let image  = UIImage(named: "line")
        view.image = image
        return view
    }()
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(GallerySheetCell.self, forCellReuseIdentifier: String(describing: GallerySheetCell.self))
        table.separatorColor = .clear
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = UIColor.theme.background
        return table
    }()
   
    private var items: [String] = ["Gallery", "Photo", "Video", "Other...", "Instagram", "Camera"]
    
}

//MARK: Private methods
private extension GallerySheetViewController {
    
    func initialize() {
        /// View
        view.backgroundColor = UIColor.theme.background
        
        /// Dismiss Button
        view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(16)
        }
        
        ///Top Icon
        view.addSubview(topImage)
        topImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(4)
        }
        
        /// Table View
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(dismissButton.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    /// Dismiss Buttona Action
    func dismissButtonAction() -> UIAction {
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
  
            self.dismiss(animated: true, completion: nil)
        }
        return action
    }
}

//MARK: TableView Delegate
extension GallerySheetViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let index = indexPath.section
        
        delegateSheet?.didChange(items[index])
        
        print("[⚠️] Selected item: \(items[index])")
        
        dismiss(animated: true)
    }
    
}

//MARK: TableView Data Source
extension GallerySheetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GallerySheetCell.self), for: indexPath) as! GallerySheetCell
        
        let type = items[indexPath.section]
        
        cell.configure(with: type)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  0
    }
    
}
