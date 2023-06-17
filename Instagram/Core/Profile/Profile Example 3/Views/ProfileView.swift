//
//  ProfileView.swift
//  Instagram
//
//  Created by Alex Karamanets on 16/06/2023.
//

//🔥 Example with SwiftUi insert in UiKit

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var vm = ProfileViewModel()
    
    let storyGrid = [GridItem(.flexible())]
    let discoverGrid = [GridItem(.flexible())]
    let galleryGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var showDiscover = false
    @State private var showStory = true
    @State private var showStoryHeader = true
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView(.vertical, showsIndicators: false) {
                    Group {
                        
                        header(size: geo.size.width)
                        
                        if showDiscover { discoverUsers }
                        
                        story(size: geo.size.width)
                        
                        posts(size: geo.size.width)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    toolBarLeft
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    toolBarRight
                }
            }
        }
        .scrollContentBackground(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background { Color.theme.background }
        .animation(.easeInOut(duration: 0.4), value: showDiscover)
        .animation(.easeInOut(duration: 0.4), value: showStory)
        .animation(.spring(), value: showStoryHeader)
    }
}

//                 🔱
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

//MARK: - Component
extension ProfileView {
    
    private var toolBarLeft: some View {
        HStack {
            Button {
                print("[🔥] Account Button Pressed")
            } label: {
                Text(vm.user.userModel?.name ?? "")
                    .foregroundColor(Color.theme.icons)
                    .font(.headline)
            }
            Button {
                print("[🔥] Show more Button Pressed")
            } label: {
                Image(systemName: "chevron.up")
                    .rotationEffect(Angle(degrees: 180))
                    .foregroundColor(Color.theme.icons)
                    .font(.headline)
            }
        }
    }
    
    private var toolBarRight: some View {
        HStack {
            Button {
                print("[🔥] Plus Button Pressed")
            } label: {
                Image(systemName: "plus.app")
                    .foregroundColor(Color.theme.icons)
                    .font(.headline)
            }
            Button {
                print("[🔥] Settings Button Pressed")
            } label: {
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(Color.theme.icons)
                    .font(.headline)
            }
        }
    }
    
    private func header(size: CGFloat) -> some View {
        
        VStack {
            HStack (spacing: 30) {
                Image(vm.user.userModel?.userImage ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: size / 3.5, height: size / 3.5)
                    .clipShape(Circle())
                
                VStack {
                    Text("\(vm.user.userModel?.posts ?? 0)")
                        .font(.headline .bold())
                        .foregroundColor(Color.theme.icons)
                    
                    Text("Posts")
                        .font(.caption2 .bold())
                        .foregroundColor(Color.theme.icons)
                }
                
                VStack {
                    Text("\(vm.user.userModel?.followers ?? 0)")
                        .font(.headline .bold())
                        .foregroundColor(Color.theme.icons)
                    
                    Text("Followers")
                        .font(.caption2 .bold())
                        .foregroundColor(Color.theme.icons)
                }
                
                VStack {
                    Text("\(vm.user.userModel?.following ?? 0)")
                        .font(.headline .bold())
                        .foregroundColor(Color.theme.icons)
                    
                    Text("Following")
                        .font(.caption2 .bold())
                        .foregroundColor(Color.theme.icons)
                }
            }
            .frame(maxWidth: .infinity)
            
            HStack {
                Button {
                    print("[🔥] Edit Profile Button Pressed")
                } label: {
                    Text("Edit Profile")
                        .foregroundColor(Color.theme.icons)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color.theme.iconBackground)
                        .cornerRadius(5)
                        .padding(.leading)
                }
                
                Button {
                    showDiscover.toggle()
                } label: {
                    Image(systemName: "person.badge.plus.fill")
                        .foregroundColor(Color.theme.icons)
                        .frame(width: 40)
                        .frame(height: 40)
                        .background(Color.theme.iconBackground)
                        .cornerRadius(5)
                        .padding(.trailing)
                }

            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var discoverUsers: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: discoverGrid, alignment: .center, spacing: 10, pinnedViews: .sectionFooters) {
                ForEach(vm.user.discoverUsers) { item in
                    DiscoverCell(discoverModel: item)
                }
                let images = vm.user.discoverUsers.map { $0.image }
                DiscoverFooter(usersImages: images)
            }
            .padding(.horizontal)
        }
    }
    
    private func story(size: CGFloat) -> some View {
        VStack {
            HStack {
                VStack (alignment: .leading, spacing: 5) {
                    Text("Story Highlights")
                        .font(.headline)
                        .foregroundColor(Color.theme.icons)
                    
                    if showStoryHeader {
                        Text("Keep your favourite story on your profile")
                            .font(.subheadline)
                            .foregroundColor(Color.theme.icons)
                    }
                }
                Spacer()
                VStack {
                    Button {
                        showStory.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            showStoryHeader.toggle()
                        }
                    } label: {
                        Image(systemName: "chevron.up")
                            .font(.title2)
                            .foregroundColor(Color.theme.icons)
                            .rotationEffect(Angle(degrees: showStory ? 180 : 0))
                    }
                    Spacer()
                }
            }
            .padding(.horizontal)
            
            if showStoryHeader {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: storyGrid) {
                        Button {
                            print("[🔥] Add new story pressed")
                        } label: {
                            Image("storyImage")
                                .resizable()
                                .frame(width: size / 5, height: size / 5)
                        }
                        ForEach(vm.user.profileStory) { item in
                            StoryCell(story: item, size: showStory ? size / 5 : .zero)
                        }
                    }
                    .padding(.leading)
                    .padding(.vertical, 10)
                }
            }
        }
    }
    
    private func posts(size: CGFloat) -> some View {
        LazyVGrid(columns: galleryGrid, alignment: .center, spacing: 3) {
            ForEach(vm.user.profileGallery) { item in
                ImageCell(post: item, size: size / 3.03)
            }
        }
        .padding(.horizontal, 2)
    }
}

