//
//  Physics.swift
//  ReefLog
//
//  Created by Alhwyn Geonzon on 2025-02-23.
//
import SwiftUI

// Data model for diving physics concepts
struct PhysicsItem: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let icon: String // SF Symbol name
}

// Diving Physics View with TikTok-style scrolling
struct DivingPhysicsView: View {
    // List of diving physics concepts
    let physicsItems: [PhysicsItem] = [
        PhysicsItem(
            name: "Pressure",
            description: "Underwater, pressure increases by 1 atmosphere (atm) every 33 feet (10 meters) due to the weight of the water above. At 33 feet, the pressure is 2 atm (1 atm from air + 1 atm from water), compressing air in your lungs and gear.",
            icon: "gauge"
        ),
        PhysicsItem(
            name: "Buoyancy",
            description: "Buoyancy determines if you float, sink, or hover. It’s governed by Archimedes’ principle: an object displacing water equal to its weight achieves neutral buoyancy. Divers use BCDs and weights to control this.",
            icon: "arrow.up.and.down"
        ),
        PhysicsItem(
            name: "Boyle’s Law",
            description: "Boyle’s Law states that as pressure increases, gas volume decreases (and vice versa). At 33 feet, air volume halves due to doubled pressure. This is why you equalize your ears and never hold your breath while ascending.",
            icon: "lungs"
        ),
        PhysicsItem(
            name: "Charles’s Law",
            description: "Charles’s Law explains how temperature affects gas volume. Colder water (e.g., deeper depths) reduces air volume in your tank slightly, while warmer water expands it. It’s a minor effect but impacts dive planning.",
            icon: "thermometer"
        ),
        PhysicsItem(
            name: "Dalton’s Law",
            description: "Dalton’s Law deals with partial pressures in gas mixes like nitrox. The total pressure is the sum of each gas’s pressure. At depth, higher oxygen pressure can lead to toxicity if limits are exceeded.",
            icon: "drop"
        ),
        PhysicsItem(
            name: "Light Refraction",
            description: "Light bends underwater, making objects appear closer and larger (about 33% magnified). Colors also fade with depth—red disappears first at around 15 feet due to water absorbing longer wavelengths.",
            icon: "lightbulb"
        ),
        PhysicsItem(
            name: "Sound Speed",
            description: "Sound travels 4 times faster underwater (about 1,500 m/s vs. 343 m/s in air) because water is denser. This makes it hard to pinpoint where sounds come from, affecting how divers communicate.",
            icon: "waveform"
        )
    ]
    
    var body: some View {
        ZStack {
            // Background MeshGradient (consistent with your app’s style)
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
                ForEach(physicsItems) { item in
                    VStack(spacing: 20) {
                        Image(systemName: item.icon)
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                            .padding(.top, 50)
                        
                        // Equipment Name
                        Text(item.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        // Description
                        Text(item.description)
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .tabViewStyle(PageTabViewStyle()) // Enables page-style swiping
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always)) // Optional: Adds page dots
        }
    }
}

#Preview {
    DivingPhysicsView()
}

