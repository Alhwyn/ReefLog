//
//  FlowLayout.swift
//  ReefLog
//
//  Created by Alhwyn Geonzon on 2025-02-18.
//

import SwiftUI

struct FlowLayout: Layout {
    
    var spacing: CGFloat = 4
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.width ?? 0, subviews: subviews, spacing: spacing)
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout()) {
        let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
        for row in result.rows {
            for element in row.elements {
                element.view.place(
                    at: CGPoint(x: bounds.minX + element.x, y: bounds.minY + row.y),
                    proposal: ProposedViewSize(element.size)
                )
            }
        }
    }
}
