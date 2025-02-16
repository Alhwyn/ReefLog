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
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 300)
            
            Text(name)
                .font(.caption)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
}

