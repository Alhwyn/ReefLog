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
