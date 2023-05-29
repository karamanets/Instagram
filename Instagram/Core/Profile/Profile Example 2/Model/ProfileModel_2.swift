//
//  ProfileModel.swift
//  Instagram
//
//  Created by Alex Karamanets on 23/05/2023.
//

import Foundation

//MARK: Story Model
struct ProfileStoryModel_2 {
    let imageName: String
}

//MARK: Gallery Model
struct ProfileGalleryModel_2 {
    let imageName: String
}

enum ProfileType_2 {
    case stories ( [ProfileStoryModel_2] )
    case gallery ( [ProfileGalleryModel_2] )
}

