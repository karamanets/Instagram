//
//  GallerySheet.swift
//  Instagram
//
//  Created by Alex Karamanets on 04/05/2023.
//

import UIKit
import SnapKit

class GallerySheet: UIViewController {
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: Private property
    private lazy var buttonSize: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.baseForegroundColor = .red
        
        let button = UIButton(configuration: config, primaryAction: toggleSize())
        return button
    }()
}

//MARK: Private methods
private extension GallerySheet {
    
    func initialize() {
        /// View
        view.backgroundColor = UIColor.theme.background
        
        view.addSubview(buttonSize)
        buttonSize.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    /// Change size of sheet with button (actions)
    func toggleSize() -> UIAction {
        
        let action = UIAction { [weak self] _ in
            
            guard let self = self else { return }
            
            // Unwrap the presentation controller using the right type.
            guard let presentationController = self.presentationController as? UISheetPresentationController else { return }
            
            // Animate the changes.
            presentationController.animateChanges {
                
                if presentationController.selectedDetentIdentifier == .medium || presentationController.selectedDetentIdentifier == nil {
                    presentationController.selectedDetentIdentifier = .large
                    self.buttonSize.setTitle("Make small", for: .normal)
                } else {
                    presentationController.selectedDetentIdentifier = .medium
                    self.buttonSize.setTitle("Make large", for: .normal)
                }
            }
        }
        return action
    }
}
