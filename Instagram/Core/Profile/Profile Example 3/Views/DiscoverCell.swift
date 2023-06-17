//
//  DiscoverCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 16/06/2023.
//

import SwiftUI

struct DiscoverCell: View {
    
    let discoverModel: DiscoverUserModel
    
    var body: some View {
        VStack {
            
            Group {
                Image(discoverModel.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.top, 5)
                
                Text(discoverModel.name)
                    .foregroundColor(Color.theme.icons)
                    .font(.caption .bold())
                
                Text("Followed by")
                    .foregroundColor(Color.theme.icons)
                    .font(.caption2)
                
                Text(" \(discoverModel.followedUsers.first ?? "") + \(discoverModel.followedUsers.count) more")
                    .foregroundColor(Color.theme.icons)
                    .font(.caption2)
                    .padding(.horizontal)
                    .lineLimit(1)
            }
            
            Group {
                Button {
                    print("[🔥] See All Button Pressed")
                } label: {
                    Text("Follow")
                        .foregroundColor(Color.white)
                        .font(.headline .bold())
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity)
                        .background(alignment: .center) {
                            Color.theme.customBlue
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .padding(.horizontal)
                }
                .padding(.bottom, 5)
            }
            
        }
        .frame(width: 140, height: 180)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.theme.iconBackground, lineWidth: 2)
        }
        .overlay(alignment: .topTrailing) {
            Button {
                print("[🔥] Close Cat Button Pressed")
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
struct DiscoverCell_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverCell(discoverModel: DiscoverUserModel(image: "image1",
                                                      name: "Cat_Red",
                                                      followedUsers: ["Cat_Slim", "Cat_Milc_my_Life"]))
    }
}
