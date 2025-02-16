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
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(name)
                .font(.caption)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 5)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
}
