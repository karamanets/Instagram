//
//  LogoView.swift
//  Instagram
//
//  Created by Alex Karamanets on 19.04.2023.
//

import UIKit
import SnapKit

//MARK: Logo Instagram for BarItem
final class LogoView: UIView {
    
    //MARK: Init
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private properties
    private var imageView: UIImageView = {
        /// preserve vector data and single scale in assets plus original render
        let image = UIImageView()
        image.image = UIImage(named: "logo")?.withTintColor(UIColor.theme.icons, renderingMode: .alwaysOriginal)
        return image
    }()
    
    //MARK: Private constants
    private enum UIConstants {
        static let logoWith: CGFloat = 104
        static let logoHeight: CGFloat = 43
    }
}

//MARK: - Private methods
private extension LogoView {
    
    func initialize() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(UIConstants.logoHeight)
            make.width.equalTo(UIConstants.logoWith)
        }
    }
}
