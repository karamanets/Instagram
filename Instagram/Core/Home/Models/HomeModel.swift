//
//  StoriesCellInfo.swift
//  Instagram
//
//  Created by Alex Karamanets on 19.04.2023.
//

import UIKit


//MARK: Story Model
struct HomeStoryModel {
    let image: UIImage
    let userName: String
    let isAddButtonVisible: Bool
    let isNewStory: Bool
}

//MARK: Post Model
struct HomePostModel {
    let userImage: UIImage
    let userName: String
    let postSubtitle: String
    let postImage: UIImage
    let numberOfLikes: Int
    let comment: CommentShortInfo?
}

struct CommentShortInfo {
    let userName: String
    let commentText: String
}

enum HomeType {
    case stories( [HomeStoryModel] )
    case post( HomePostModel )
}
