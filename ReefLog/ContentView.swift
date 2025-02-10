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
            HomeView()
                .tabItem {
                    Label("Scuba Guide", systemImage: "info.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
