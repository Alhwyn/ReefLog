//
//  ReefLogApp.swift
//  ReefLog
//
//  Created by Alhwyn Geonzon on 2025-02-06.
//
import SwiftUI

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemThinMaterial)
        appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.3)

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        if hasSeenOnboarding {
            TabView {
                HomeView()
                    .tabItem { Label("Dives Log", systemImage: "water.waves") }
                FishListView()
                    .tabItem { Label("Reef Catalog", systemImage: "fish") }
                ScubaGuide()
                    .tabItem { Label("Scuba Guide", systemImage: "info.circle") }
            }
        } else {
            OnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
        }
    }
}

@main
struct ReefLogApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#Preview {
    ContentView()
}
