//
//  DiveMedicine.swift
//  ReefLog
//
//  Created by Alhwyn Geonzon on 2025-02-23.
//

import SwiftUI

struct MedicineItem: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let icon: String // SF Symbol name
}

struct HealthCheckView: View {
    
    let healthItems: [MedicineItem] = [
        MedicineItem(
            name: "Panic-Induced Glottis Cramp",
            description: "The glottis is the opening between the vocal cords in your throat. If water accidentally enters the larynx during a panic, it can cause a glottis cramp, making breathing difficult or impossible.",
            icon: "mouth"
        ),
        MedicineItem(
            name: "Barotrauma of the Eyes",
            description: "Barotrauma occurs when you fail to equalize pressure in your dive mask, causing blood vessels in your eyes to rupture and bleed.",
            icon: "eye"
        ),
        MedicineItem(
            name: "Decompression Sickness (DCS)",
            description: "DCS, also known as 'the bends,' occurs when nitrogen bubbles form in your bloodstream due to rapid ascent, leading to symptoms like joint pain, dizziness, or even paralysis.",
            icon: "lungs"
        ),
        MedicineItem(
            name: "Barotrauma of the Sinus",
            description: "Sinus barotrauma happens when you don’t equalize sinus pressure, causing severe pain in the forehead or face.",
            icon: "face.dashed"
        ),
        MedicineItem(
            name: "Nitrogen Narcosis",
            description: "Nitrogen narcosis, sometimes called 'rapture of the deep,' results from nitrogen absorption at depth, impairing logic and judgment, similar to intoxication.",
            icon: "brain"
        ),
        MedicineItem(
            name: "Barotrauma of the Ear",
            description: "Ear barotrauma causes ear pain, ringing, bleeding, or temporary hearing loss due to delayed pressure equalization during descent.",
            icon: "ear"
        )
    ]
    
    var body: some View {
        GeometryReader { geometry in
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
                
                // Vertical scrolling view
                TabView {
                    ForEach(healthItems) { item in
                        VStack(spacing: 20) {
                            Image(systemName: item.icon)
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                                .padding(.top, 50)
                            
                            Text(item.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            Text(item.description)
                                .font(.body)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                            
                            Spacer()
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .background(Color.black.opacity(0.05))
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
        }
    }
}

#Preview {
    HealthCheckView()
}
