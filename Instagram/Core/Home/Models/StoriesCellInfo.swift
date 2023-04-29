//
//  StoriesCellInfo.swift
//  Instagram
//
//  Created by Alex Karamanets on 19.04.2023.
//

import UIKit


//MARK: Stories Model
struct StoriesItemCellInfo {
    let image: UIImage
    let userName: String
    let isAddButtonVisible: Bool
    let isNewStory: Bool
}

typealias StoriesCellInfo = [StoriesItemCellInfo]
