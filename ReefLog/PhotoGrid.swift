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
            LazyHStack(spacing: 5) {
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
                }
            }
        }
        .scrollTargetBehavior(.paging)
    }
}
