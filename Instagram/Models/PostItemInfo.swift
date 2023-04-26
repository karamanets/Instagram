//
//  PostItemInfo.swift
//  Instagram
//
//  Created by Alex Karamanets on 19.04.2023.
//

import UIKit

//MARK: Post Model
struct FeedPostItemInfo {
    let userImage: UIImage
    let userName: String
    let postSubtitle: String
    let postImage: UIImage
    let numberOfLiks: Int
    let comment: CommentShortInfo?
}

struct CommentShortInfo {
    let userName: String
    let commentText: String
}
