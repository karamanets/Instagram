//
//  Color.swift
//  Instagram
//
//  Created by Alex Karamanets on 03/05/2023.
//

import UIKit
import SwiftUI

extension UIColor {
    
    static let theme = ColorsTheme()
}

struct ColorsTheme {
    
    let background = UIColor(named: "background")                         ?? .systemGroupedBackground
    let icons = UIColor(named: "icons")                                   ?? .systemGroupedBackground
    let iconBackground = UIColor(named: "iconBackground")                 ?? .systemGroupedBackground
    let iconStroke = UIColor(named: "iconStroke")                         ?? .systemGroupedBackground
    let shadow = UIColor(named: "shadow")                                 ?? .systemGroupedBackground
    let textFieldBackground = UIColor(named: "textFieldIcon")             ?? .systemGroupedBackground
    let newPostImageBack = UIColor(named: "newPostImageBack")             ?? .systemGroupedBackground
    let searchTextFieldBackground = UIColor(named: "textFieldSearchBack") ?? .systemGroupedBackground
    let sheetBackground = UIColor(named: "sheetBackground")               ?? .systemGroupedBackground
    let textColor = UIColor(named: "textColor")                           ?? .systemGroupedBackground
    let customBlue = UIColor(named: "customBlue")                         ?? .systemGroupedBackground
}

extension Color {
    
    static let theme = ColorsThemeSwiftUi()
}

struct ColorsThemeSwiftUi {
    
    let background = Color("background")
    let icons = Color("icons")
    let textColor = Color("textColor")
    let iconBackground = Color("iconBackground")
    let customBlue = Color("customBlue")
}
