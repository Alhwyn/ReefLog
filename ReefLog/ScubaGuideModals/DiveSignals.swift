//
//  DiveSignals.swift
//  ReefLog
//
//  Created by Alhwyn Geonzon on 2025-02-23.
//

import SwiftUI

// Data model for scuba signals
struct SignalItem: Identifiable {
    let id = UUID()
    let name: String // The meaning of the signal (e.g., "OK")
    let imageName: String // Name of the image asset
}

struct ScubaSignalsView: View {

    let signalItems: [SignalItem] = [
        SignalItem(
            name: "OK",
            imageName: "signal_ok"
        ),
        SignalItem(
            name: "Stop",
            imageName: "signal_stop"
        ),
        SignalItem(
            name: "Up",
            imageName: "signal_up"
        ),
        SignalItem(
            name: "Down",
            imageName: "signal_down"
        ),
        SignalItem(
            name: "Something's wrong",
            imageName: "signal_something_wrong"
        ),
        SignalItem(
            name: "Ear Not Clearing",
            imageName: "signal_ear"
        ),
        SignalItem(
            name: "Come Here",
            imageName: "signal_here"
        ),
        SignalItem(
            name: "Watch me",
            imageName: "signal_watch_me"
        ),
        SignalItem(
            name: "Get with your buddy",
            imageName: "signal_buddy"
        ),
        SignalItem(
            name: "Low on air",
            imageName: "signal_low_air"
        ),
        SignalItem(
            name: "Out of Air",
            imageName: "signal_no_air"
        ),
        SignalItem(
            name: "Share Air",
            imageName: "signal_share_air"
        ),
        SignalItem(
            name: "How much air?",
            imageName: "signal_how_much_air"
        ),
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background MeshGradient with a "cute" twist (softer colors)
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
                
     
                TabView {
                    ForEach(signalItems) { item in
                        VStack(spacing: 30) {
                         
                            Image(item.imageName) // Replace with your actual image assets
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300) // Sized for visibility
                                .clipShape(RoundedRectangle(cornerRadius: 20)) // Rounded for a "cute" feel
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white.opacity(0.8), lineWidth: 4) // Soft border
                                )
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                                .padding(.top, 50)

                            Text(item.name)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.teal.opacity(0.3))
                                .clipShape(Capsule()) // Capsule shape for a playful look
                                .overlay(
                                    Capsule()
                                        .stroke(Color.white.opacity(0.5))
                                )
                            
                            Spacer()
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height) // Full-screen page
                        .background(Color.black.opacity(0.05)) // Subtle page background
                    }
                }
                .tabViewStyle(PageTabViewStyle()) // Enables page-style swiping
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always)) // Optional: Adds page dots
            }
        }
    }
}

#Preview {
    ScubaSignalsView()
}




