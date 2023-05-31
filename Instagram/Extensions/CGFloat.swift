//
//  CGFloat.swift
//  Instagram
//
//  Created by Alex Karamanets on 31/05/2023.
//

import Foundation

extension CGFloat {
    
    ///Method for get height of view and return current height for row
    func getCustomRowHeight(with size: CGFloat) -> CGFloat {
        
        /// Different height size
        let sizeSE = size / 6.5
        let sizeMAX = size / 7.5
        let sizeIPad = size / 5.5
        
        if size <= 670 {
            return sizeSE
        } else if size <= 940 {
            return sizeMAX
        } else {
            return sizeIPad
        }
    }
    
    ///Resize Header height for different device in ProfileVC
    func getCustomHeaderHeightProfile(with size: CGFloat) -> CGFloat {
        
        /// Different height size
        let sizeSE = size / 2.15
        let sizeMAX = size / 2.75
        let sizeIPad = size / 2.1
        
        if size <= 670 {
            return sizeSE
        } else if size <= 940 {
            return sizeMAX
        } else {
            return sizeIPad
        }
    }
    
    ///Resize Header height for different device in SearchVC
    func getCustomHeaderHeightSearch(with size: CGFloat) -> CGFloat {
        
        /// Different height size
        let sizeSE = size / 10
        let sizeMAX = size / 11
        let sizeIPad = size / 15
        
        if size <= 670 {
            return sizeSE
        } else if size <= 940 {
            return sizeMAX
        } else {
            return sizeIPad
        }
    }
    
    private func reSize(_ size: CGFloat, type: Device) -> CGFloat  {
        
        switch type {
        case .iPhoneSE:
            return type.rawValue
        case .iPhoneMAX:
            return type.rawValue
        case .iPad:
            return type.rawValue
        }
    }
    
    private enum Device: CGFloat {
        case iPhoneSE  = 670
        case iPhoneMAX = 940
        case iPad      = 1300
    }
}

