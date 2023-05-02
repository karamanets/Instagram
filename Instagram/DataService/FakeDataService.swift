//
//  FakeDataService.swift
//  Instagram
//
//  Created by Alex Karamanets on 20.04.2023.
//

import UIKit

struct FakeDataService {
    
    //MARK: Public
    var arrayFakeDataTypeStoryAndPostForHomeVC: [InstagramItemType] = []
    
    var arrayFakeDataImages: [UIImage] = []
    
    //MARK: Init
    init() {
        setUpDataPost()
        setUpArrayOfImagesForSearchVC()
    }
    
    //MARK: Private methods
    private mutating func setUpDataPost() {
        
        var tempData: [InstagramItemType] = []
        
        for _ in 1...100 {
            let post: InstagramItemType = .post(PostItemInfo(userImage: setUpRandomImage(),
                                                            userName: setUpRandomName(),
                                                            postSubtitle: setUpRandomSubtitle(),
                                                            postImage: setUpRandomImage(),
                                                            numberOfLiks: setUpRandomLike(),
                                                            comment: CommentShortInfo(userName: setUpRandomName(), commentText: setUpRandomComment())))
            
            tempData.append(post)
        }
        
        tempData.insert(.stories(setUpDataStoriesArray()), at: 0)
        
        arrayFakeDataTypeStoryAndPostForHomeVC = tempData
    }
    
    private func setUpDataStoriesArray() -> [StoriesItemCellInfo] {

        var tempArray: [StoriesItemCellInfo] = []

        for _ in 1...100 {
            let story = StoriesItemCellInfo(image: setUpRandomImage(), userName: setUpRandomName(), isAddButtonVisible: false, isNewStory: setUpRandomIsNew())
            tempArray.append(story)
        }
        return tempArray
    }
    
    private func setUpRandomName() -> String {
        let userName = ["Cat_boss",
                    "Cat",
                    "Cat_milk_MyLife",
                    "Whiskers",
                    "Cat_Shadow",
                    "Cat_Smokey",
                    "Cat_Midnight",
                    "Cat_Lucky",
                    "Cat_Salem",
                    "Cat_Boots",
                    "Cat_Simba",
                    "Cat_Oliver",
                    "Cat_Gizmo",
                    "Cat_Tiger",
                    "Cat_Leo",
                    "Cat_Max",
                    "Cat_Oreo",
                    "Cat_Garfield",
                    "Cat_Tom",
                    "Cat_Socks",
                    "Cat_Charlie",
                    "Cat_Felix",
                    "Cat_Milo" ].randomElement() ?? ""
        return userName
    }
    
    private func setUpRandomSubtitle() -> String {
        let subtitle = ["Sponsored", setUpRandomName()].randomElement() ?? ""
        return subtitle
    }
    
    private func setUpRandomLike() -> Int {
        let like = Int.random(in: 0...1000)
        return like
    }
    
    func setUpRandomImage() -> UIImage {
        let imagesName = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10"].randomElement()
        let image = UIImage(named: imagesName ?? "")
        return image ?? UIImage()
    }
    
    private mutating func setUpArrayOfImagesForSearchVC() {
        var tempImageArray: [UIImage] = []
        
        for _ in 1...100 {
            tempImageArray.append(setUpRandomImage())
        }
        arrayFakeDataImages = tempImageArray
    }
    
    private func setUpRandomComment() -> String {
        let commentText = ["Aww, that cat is so adorable!",
                       "I wish I could cuddle with that cat right now!",
                       "This cat looks like it's plotting something mischievous.",
                       "I can't get enough of cute cat pictures like this!",
                       "That cat has the most beautiful eyes I've ever seen.",
                       "Looks like this cat knows how to live its best life!",
                       "I'm so jealous of how relaxed and content that cat looks.",
                       "This cat is definitely the ruler of its household.",
                       "I bet that cat is thinking about all the trouble it's going to get into next!",
                       "I can't believe how photogenic this cat is!",
                       "That cat has a personality that shines through in every picture.",
                       "I would love to have a cat like this as my own.",
                       "This cat is the definition of 'cat-titude'.",
                       "That cat looks like it's living its best nine lives.",
                       "I can't handle the cuteness of this cat!",
                       "That cat looks like it's judging us all with its eyes.",
                       "I think this cat knows exactly how adorable it is.",
                       "I bet this cat is a master at knocking things off of shelves.",
                       "This cat has definitely found the perfect spot to take a nap.",
                       "I think we can all agree that cats are the rulers of the internet!"].randomElement()
        return commentText ?? "Haha"
    }
    
    private func setUpRandomIsNew() -> Bool {
        let isNewStory = [true, false].randomElement()
        return isNewStory ?? false
    }
}
