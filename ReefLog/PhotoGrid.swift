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
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(images) { item in
                    PhotoGridItem(image: item.image, name: item.name)
                }
            }
            .padding(10)
        }
        .frame(maxHeight: 400)
    }
}
