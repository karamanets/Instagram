//
//  DiscoverFooter.swift
//  Instagram
//
//  Created by Alex Karamanets on 16/06/2023.
//

import SwiftUI

struct DiscoverFooter: View {
    
    let usersImages: [String]

    var body: some View {
        VStack {
            
            Group {
                ZStack {
                    if let image = usersImages.first {
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                    }
                    
                    if let image = usersImages.last {
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 80, height: 80 )
                        
                            .overlay(content: {
                                Circle()
                                    .stroke(Color.theme.background, lineWidth: 3)
                            })
                            .offset(x: 15, y: 15)
                    }
                }
            }
            .padding(.top, 5)

            Group {
                Text("Find More Cats")
                    .foregroundColor(Color.theme.icons)
                    .font(.caption2 .bold())
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .lineLimit(1)
                
                Text("to Follow")
                    .foregroundColor(Color.theme.icons)
                    .font(.caption2 .bold())
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .lineLimit(1)
            }
            .offset(y: 15)
            
            Group {
                Button {
                    print("[🔥] See All Button Pressed")
                } label: {
                    Text("See all")
                        .foregroundColor(Color.theme.textColor)
                        .font(.callout)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity)
                        .background{ Color.theme.iconBackground  }
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .padding(.horizontal)
                }
                .padding(.bottom, 5)
                .padding(.top)
            }
            
        }
        .frame(minWidth: 140, minHeight: 180)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.theme.iconBackground, lineWidth: 2)
        }
        .overlay(alignment: .topTrailing) {
            Button {
                //some
            } label: {
                Image(systemName: "xmark")
                    .padding(.all, 10)
                    .foregroundColor(Color.theme.icons)
                    .font(.callout .bold())
            }
        }
    }
}

//                 🔱
struct DiscoverFooter_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverFooter(usersImages: ["image1", "image11"])
    }
}
