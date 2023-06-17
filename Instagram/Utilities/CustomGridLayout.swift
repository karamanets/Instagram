//
//  CustomGridLayout.swift
//  Instagram
//
//  Created by Alex Karamanets on 17/06/2023.
//

import SwiftUI

//🔥 Make LazyVGrid is not lazy -> because UiKit show animation collapsing is not correct with lazyVGrid

struct CustomGridLayout<Element, GridCell>: View where GridCell: View {
    
    private var array: [Element]
    private var numberOfColumns: Int
    private var gridCell: (_ element: Element) -> GridCell
    private var spacing: CGFloat
    
    init(_ array: [Element], numberOfColumns: Int, spacing: CGFloat, @ViewBuilder gridCell: @escaping (_ element: Element) -> GridCell) {
        self.array = array
        self.numberOfColumns = numberOfColumns
        self.gridCell = gridCell
        self.spacing = spacing
    }
    
    var body: some View {
        Grid {
            ForEach(Array(stride(from: 0, to: self.array.count, by: self.numberOfColumns)), id: \.self) { index in
                GridRow {
                    ForEach(0..<self.numberOfColumns, id: \.self) { j in
                        if let element = self.array.getElementAt(index: index + j) {
                            self.gridCell(element)
                        }
                    }
                    .padding(spacing)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension Array {
    func getElementAt(index: Int) -> Element? {
        return (index < self.endIndex) ? self[index] : nil
    }
}
