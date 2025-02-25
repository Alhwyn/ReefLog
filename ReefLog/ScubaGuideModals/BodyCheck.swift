//
//  BodyCheck.swift
//  ReefLog
//
//  Created by Alhwyn Geonzon on 2025-02-23.
//

import SwiftUI


struct BodyCheckItem: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let icon: String 
}


struct DivingBodyCheckView: View {

    let bodyCheckItems: [BodyCheckItem] = [
 
        BodyCheckItem(
            name: "Ear Health",
            description: "Check your ears for infections or blockages. Equalizing pressure is crucial underwater, so avoid diving with a cold or ear issues.",
            icon: "ear"
        ),
        BodyCheckItem(
            name: "Hydration",
            description: "Stay hydrated before diving. Dehydration increases the risk of decompression sickness. Drink water, not alcohol, pre-dive.",
            icon: "drop.fill"
        ),
        BodyCheckItem(
            name: "Breathing Check",
            description: "Ensure your lungs feel clear. Avoid diving with a cough or congestion, as it can hinder equalization and increase barotrauma risk.",
            icon: "lungs"
        ),
        BodyCheckItem(
            name: "Physical Fitness",
            description: "Assess your energy levels and fitness. Diving requires strength for currents and emergencies—don’t dive if you’re exhausted.",
            icon: "figure.walk"
        ),
        // Hygiene
        BodyCheckItem(
            name: "Skin Protection",
            description: "Apply sunscreen to exposed skin and rinse saltwater off after diving to avoid irritation. Check for cuts or abrasions that could get infected.",
            icon: "sun.max"
        ),
        BodyCheckItem(
            name: "Gear Hygiene",
            description: "Clean your regulator, mask, and fins after each dive with fresh water. Bacteria can grow in damp gear, so dry it thoroughly.",
            icon: "gearshape"
        ),
        BodyCheckItem(
            name: "Oral Hygiene",
            description: "Brush your teeth before diving to reduce bacteria in your mouth. A clean mouthpiece prevents bad tastes or infections.",
            icon: "mouth"
        ),
        BodyCheckItem(
            name: "Mask Fit",
            description: "Test your mask for a snug fit. Place it on your face without straps and inhale gently—it should seal without leaks for clear vision underwater.",
            icon: "eye"
        ),
        BodyCheckItem(
            name: "Regulator Function",
            description: "Breathe through your regulator before diving to ensure smooth airflow. Check both primary and backup (octopus) for leaks or resistance.",
            icon: "wind"
        ),
        BodyCheckItem(
            name: "BCD Inspection",
            description: "Inflate your BCD to check for leaks and test the deflate valves. Ensure straps are secure and weights are properly placed.",
            icon: "water.waves"
        ),
        BodyCheckItem(
            name: "Fins Condition",
            description: "Inspect your fins for cracks or loose straps. Open-heel fins should fit snugly with dive boots to avoid slipping off underwater.",
            icon: "figure.pool.swim"
        ),
        BodyCheckItem(
            name: "Tank Pressure",
            description: "Check your tank’s pressure gauge—ensure it’s full (e.g., 3000 psi/200 bar). Verify the valve opens smoothly without hissing.",
            icon: "cylinder"
        )
    ]
    
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
            

            TabView {
                ForEach(bodyCheckItems) { item in
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
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }
}

#Preview {
    DivingPhysicsView()
}

