//
//  ProfileViewMode.swift
//  Instagram
//
//  Created by Alex Karamanets on 16/06/2023.
//

import Foundation


final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user = FakeDataService.shared
}
