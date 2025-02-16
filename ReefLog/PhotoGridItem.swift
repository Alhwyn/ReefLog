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
            .scaledToFill()
            .overlay(alignment: .bottom) {
                HStack {
                    Text(name)
                        .font(.largeTitle)
       
                    Spacer()

                }
                .multilineTextAlignment(.center)
                .background(.thinMaterial)
                
            }
            
            
        
    }
}
