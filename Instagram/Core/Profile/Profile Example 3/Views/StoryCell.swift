//
//  StoryCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 16/06/2023.
//

import SwiftUI

struct StoryCell: View {
    
    let story: ProfileStoryModel
    let size: CGFloat
    
    var body: some View {
        Group {
            Image(story.imageName)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .shadow(color: Color.theme.icons.opacity(0.5), radius: 3, x: 2, y: 2)
                .frame(width: size, height: size)
        }
    }
}

//              🔱
struct StoryCell_Previews: PreviewProvider {
    static var previews: some View {
        StoryCell(story: ProfileStoryModel(imageName: "image2"), size: 80)
    }
}
