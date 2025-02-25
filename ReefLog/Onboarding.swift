//
//  Onboarding.swift
//  ReefLog
//
//  Created by Alhwyn Geonzon on 2025-02-23.
//
import SwiftUI

struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Welcome to ReefLog!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.7))
                .multilineTextAlignment(.center)
            
            Image(systemName: "fish")
                .font(.system(size: 80))
                .foregroundColor(Color.white.opacity(0.7))
            
            Text("Track your dives, log fish sightings, and explore the underwater world.")
                .font(.body)
                .foregroundColor(Color.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            Button(action: {
                hasSeenOnboarding = true // Mark onboarding as completed
            }) {
                Text("Get Started")
                    .font(.headline)
                    .foregroundColor(Color.white.opacity(0.7))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
        .background(MeshGradient(
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
        .ignoresSafeArea())
    }
}



#Preview {
    ContentView()
}
