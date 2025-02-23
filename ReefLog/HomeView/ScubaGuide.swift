//
//  ScubaGuide.swift
//  ReefLog
//
//  Created by Alhwyn Geonzon on 2025-02-19.
//

import SwiftUI

struct ScubaGuide: View {
    
    // Updated cards with SF Symbols (no descriptions needed)
    let cards = [
        ("Scuba Equipment", "water.waves"), // Diver symbol
        ("Diving Medicine", "cross.case"),        // Medical symbol
        ("Diving Physics", "gauge"),              // Physics/pressure symbol
        ("Scuba Signals", "hand.raised")          // Hand signal symbol
    ]
    
    // Define the 2x2 grid layout
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        ZStack {
            // Background MeshGradient
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
            
            // Main Content
            ScrollView {
                VStack(spacing: 20) {
                    // Title
                    Text("Scuba Guide")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .padding(.top, 40)
                        .padding(.bottom, 10)
                    
                    // 2x2 Grid of Button Cards
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(cards, id: \.0) { title, symbol in
                            Button(action: {
                                // Action for button tap (placeholder)
                                print("\(title) tapped!")
                            }) {
                                VStack(spacing: 10) {
                                    Image(systemName: symbol)
                                        .font(.system(size: 30))
                                        .foregroundColor(.white)
                                    Text(title)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(maxWidth: .infinity, minHeight: 120)
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(15)
                                .shadow(radius: 5)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    ScubaGuide()
}
