//
//  FlowResult.swift
//  ReefLog
//
//  Created by Alhwyn Geonzon on 2025-02-18.
//

import SwiftUI

struct FlowResult {
    /// calculates the positions and sizes of subviews for a flow layout
    /// wrapping elements into new rows when they exceed the given width
    /// very similar to the groupSightings function
    
    var size: CGSize
    var rows: [Row]
    
    struct Row {
        var y: CGFloat
        var height: CGFloat
        var elements: [Element]
        
    }
    
    struct Element {
        var x: CGFloat
        var size: CGSize
        var view: LayoutSubview
        
    }
    
    init(in width: CGFloat, subviews: LayoutSubviews, spacing: CGFloat) {
        var rows: [Row] = []
        var currentRow  = Row(y: 0, height: 0, elements: [])
        var x: CGFloat = 0
        var y: CGFloat = 0
        var maxWidth: CGFloat = 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            
            if x + size.width > width && !currentRow.elements.isEmpty {
                rows.append(currentRow)
                y += currentRow.height + spacing
                x = 0
                currentRow = Row(y: y, height: 0, elements: [])
                
            }
            currentRow.elements.append(Element(x: x, size: size, view: subview))
            currentRow.height = max(currentRow.height, size.height)
            x += size.width + spacing
            maxWidth = max(maxWidth, x)
        }
        
        if !currentRow.elements.isEmpty {
            rows.append(currentRow)
            y += currentRow.height
        }
        
        self.rows = rows
        self.size = CGSize(width: maxWidth, height: y)
    }
}
