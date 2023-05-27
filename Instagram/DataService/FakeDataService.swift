//
//  FakeDataService.swift
//  Instagram
//
//  Created by Alex Karamanets on 20.04.2023.
//

import UIKit
import AVKit

@MainActor
final class FakeDataService {
    
    static let shared = FakeDataService()
    
    //MARK: Public
    public var homeType: [HomeType] = []
    
    public var arrayImages: [String] = []
    
    public var userImage: UIImage? = nil
    
    public var reelsModels: [ReelsModel] = []
    
    public var userName: String? = nil
    
    public var profileStory: [ProfileStoryModel] = []
    
    public var profileType: [ProfileType] = []
    
    //MARK: Init
    private init() {
        userSetUp()
        setUpDataPost()
        setUpArrayOfImagesForSearchVC()
        setUpReels()
        setUpUserName()
        setUpProfileStory()
        setUpProfile()
    }
    
    //MARK: Methods
    private func setUpProfileStory() {
        
        var temp: [ProfileStoryModel] = []
        
        for _ in 1...100 {
            let story = ProfileStoryModel(imageName: setUpRandomImageName())
            temp.append(story)
        }
        self.profileStory = temp
    }
    
    private func setUpRandomImage() -> UIImage {
        
        let imagesName = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10", "image11", "image12", "image13", "image14", "image15"].randomElement()
        
        let image = UIImage(named: imagesName ?? "")
        return image ?? UIImage()
    }
    
    private func setUpReels() {
        
        var temp: [ReelsModel] = []
        
        for _ in 1...6 {
            
            let reels = ReelsModel(reels: setUpRandomVideo(),
                                    avpController: AVPlayerViewController(),
                                    volume: 5,
                                    comment: [setUpRandomComment()],
                                    numberOfLikes: setUpRandomLike(),
                                    numberOfComment: setUpRandomLike(),
                                    numberOfShare: setUpRandomLike(),
                                    treck: "mc.cat",
                                    reelsUser: User(userID: UUID().uuidString,
                                                    userName: setUpRandomName(),
                                                    userImage: setUpRandomImage(),
                                                    userSubtitle: setUpRandomSubtitle()))
            temp.append(reels)
        }
        self.reelsModels = temp
    }
    
    private func setUpRandomVideo() -> String {
        let video = ["cat1", "cat2", "cat3", "cat4"].randomElement()
        return video ?? "cat1"
    }
    
    private func userSetUp() {
        let userImage = setUpRandomImage()
        self.userImage = userImage
    }
    
    private func setUpUserName() {
        self.userName = setUpRandomName()
    }
    
    //========== Home ViewController
    
    private func setUpDataPost() {
        
        var tempData: [HomeType] = []
        
        for _ in 1...100 {
            let post: HomeType = .post(HomePostModel(userImage: setUpRandomImage(),
                                                            userName: setUpRandomName(),
                                                            postSubtitle: setUpRandomSubtitle(),
                                                            postImage: setUpRandomImage(),
                                                            numberOfLikes: setUpRandomLike(),
                                                             
                                                            comment: CommentShortInfo(userName: setUpRandomName(),
                                                                                      commentText: setUpRandomComment())))
            tempData.append(post)
        }
        
        tempData.insert(.stories(setUpDataStoriesArray()), at: 0)
        
        homeType = tempData
    }
    
    private func setUpDataStoriesArray() -> [HomeStoryModel] {

        var tempArray: [HomeStoryModel] = []
        
        let userStories = HomeStoryModel(image: setUpRandomImage(),
                                              userName: setUpRandomName(),
                                              isAddButtonVisible: true,
                                              isNewStory: setUpRandomIsNew())
        tempArray.append(userStories)

        for _ in 1...100 {
            let story = HomeStoryModel(image: setUpRandomImage(), userName: setUpRandomName(), isAddButtonVisible: false, isNewStory: setUpRandomIsNew())
            tempArray.append(story)
        }
        
        return tempArray
    }
    
    //========== Profile ViewController
    
    private func setUpProfile() {
        
        var temp: [ProfileType] = []
        
        let story = setUpProfileStoriesArray()
        
        temp.insert(.stories(story), at: 0)
        
        for _ in 1...100 {
            let imagesName = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10", "image11", "image12", "image13", "image14", "image15"].randomElement()
            
            temp.append(.gallery(ProfileGalleryModel(imageName: imagesName ?? "")))
        }
        
        self.profileType = temp
    }
    
    private func setUpProfileStoriesArray() -> [ProfileStoryModel] {
        
        var temp: [ProfileStoryModel] = []
        
        for _ in 1...100 {
            let imagesName = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10", "image11", "image12", "image13", "image14", "image15"].randomElement()
            
            temp.append(ProfileStoryModel(imageName: imagesName ?? ""))
        }
        
        return temp
    }
    
    //=========== Else
    
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
    
    private func setUpRandomImageName() -> String {
        
        let imagesName = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10", "image11", "image12", "image13", "image14", "image15"].randomElement()
        
        return imagesName ?? ""
    }
    
    private func setUpRandomSubtitle() -> String {
        let subtitle = ["Sponsored", setUpRandomName()].randomElement() ?? ""
        return subtitle
    }
    
    private func setUpRandomLike() -> Int {
        let like = Int.random(in: 0...1000)
        return like
    }
    
    private func setUpArrayOfImagesForSearchVC() {
        var tempImageArray: [String] = []
        for _ in 1...100 {
            
            guard let imagesName = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10", "image11", "image12", "image13", "image14", "image15"].randomElement() else { return }
            
            tempImageArray.append(imagesName)
        }
        arrayImages = tempImageArray
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
