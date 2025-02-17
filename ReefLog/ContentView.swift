import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.white.withAlphaComponent(0.7)
        UITabBar.appearance().tintColor = UIColor.gray
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Dives Log", systemImage: "water.waves")
                }
            FishListView()
                .tabItem {
                    Label("Reef Catalog", systemImage: "fish")
                }
            FishListView()
                .tabItem {
                    Label("Scuba Guide", systemImage: "info.circle")
                }
        }
        .background(.blue)
    }
}

#Preview {
    ContentView()
}
