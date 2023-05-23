//
//  StoriesCellInfo.swift
//  Instagram
//
//  Created by Alex Karamanets on 19.04.2023.
//

import UIKit


//MARK: Stories Model
struct StoriesModel {
    let image: UIImage
    let userName: String
    let isAddButtonVisible: Bool
    let isNewStory: Bool
}

typealias StoriesCells = [StoriesModel]

//MARK: Post Model
struct PostModel {
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

enum InstagramItemType {
    case stories(StoriesCells)
    case post(PostModel)
}
