//
//  Color.swift
//  Instagram
//
//  Created by Alex Karamanets on 03/05/2023.
//

import UIKit

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
}
