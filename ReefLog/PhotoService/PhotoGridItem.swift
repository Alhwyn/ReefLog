//
//  PhotoGridItem.swift
//  ReefLog
//
//  Created by Alhwyn Geonzon on 2025-02-15.
//

import SwiftUI

struct PhotoGridItem: View {
    let image: UIImage
    let name: String
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 300, height: 300)
            .clipped()
            .overlay(alignment: .bottom) {
                Text(name)
                    .font(.subheadline)
                    .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4))
                    .frame(maxWidth: .infinity) // ✅ Ensures text spans the full width
                    .background(.thinMaterial)
                    .multilineTextAlignment(.center)
            }
    }
}
