import SwiftUI

struct ContentView: View {

    
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
        .background(.ultraThinMaterial)
    }
}

#Preview {
    ContentView()
}
