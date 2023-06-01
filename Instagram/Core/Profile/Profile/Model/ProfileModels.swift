//
//  ProfileModel.swift
//  Instagram
//
//  Created by Alex Karamanets on 29/05/2023.
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

//MARK: User Model
struct UserModel {
    let name: String
    let userImage: String
    let posts: Int
    let followers: Int
    let following: Int
}

//MARK: Discover UserModel
struct DiscoverUserModel {
    let image: String
    let name: String
    let followedUsers: [String]
}
