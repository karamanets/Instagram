//
//  ProfileModel.swift
//  Instagram
//
//  Created by Alex Karamanets on 23/05/2023.
//

import Foundation

//MARK: Story Model
struct ProfileStoryModel {
    let imageName: String
}

//MARK: Gallery Model
struct ProfileGalleryModel {
    let imageName: String
}

enum ProfileType {
    case stories ( [ProfileStoryModel] )
    case gallery ( ProfileGalleryModel )
}
