//
//  PhotoGridItem.swift
//  ReefLog
//
//  Created by Alhwyn Geonzon on 2025-02-15.
//

import SwiftUI

struct PhotoGridItem: View {
    /// This is the ayout of the PhotoGrid items as well as the lable of the classifcation of the image fomr the image model
    ///
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
                    .frame(maxWidth: .infinity) //
                    .background(.thinMaterial)
                    .multilineTextAlignment(.center)
            }
    }
}
