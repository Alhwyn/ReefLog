//
//  ScubaGuide.swift
//  ReefLog
//
//  Created by Alhwyn Geonzon on 2025-02-19.
//

import SwiftUI


struct ScubaGuide: View {
    
    var body: some View {
        ZStack {
            
            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [0.9, 0.3], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    .teal, .teal, .teal,
                    .cyan, .cyan, .cyan,
                    .cyan, .cyan, .cyan
                ]
            )
            .ignoresSafeArea()
        }
        
    }
    
}


#Preview {
    ScubaGuide()
}
