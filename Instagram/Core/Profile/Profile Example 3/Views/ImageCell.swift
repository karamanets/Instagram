//
//  GalleryCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 16/06/2023.
//

import SwiftUI

struct ImageCell: View {
    
    let post: ProfileGalleryModel
    let size: CGFloat
    
    var body: some View {
        VStack {
            Image(post.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: 4))
        }
    }
}

struct ImageCell_Previews: PreviewProvider {
    static var previews: some View {
        ImageCell(post: ProfileGalleryModel(imageName: "image2"), size: 100)
    }
}
