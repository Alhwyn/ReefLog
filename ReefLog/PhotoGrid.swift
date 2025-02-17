//
//  PhotoGrid.swift
//  ReefLog
//
//  Created by Alhwyn Geonzon on 2025-02-15.
//

import SwiftUI


struct PhotoGrid: View {
    let images: [NamedImage]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                
                if images.isEmpty {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.ultraThinMaterial)
                            .frame(width: 300, height: 300)
                        Text("No Photos")
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } else {
                    
                    ForEach(images) { item in
                        ZStack {
                            PhotoGridItem(image: item.image, name: item.name)
                                .scrollTransition(
                                    axis: .horizontal
                                ) { content, phase in
                                    return content
                                        .offset(x: phase.value * -270)
                            }
                        }
                        .containerRelativeFrame(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: 32))
                        .background(.clear)
                    }
                }
                
            }
        }
        .scrollTargetBehavior(.paging)
    }
}
