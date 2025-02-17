import SwiftUI

struct FishListView: View {
    @StateObject var database = FishDatabase()
    
    var body: some View {
        NavigationView {
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
                        .cyan, .cyan, .blue,
                        .cyan, .cyan, .teal,
                        .teal, .teal, .green
                    ]
                )
                .ignoresSafeArea()
                
                List {
                    ForEach(database.fishList) { fish in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(fish.name)
                                    .font(.headline)
                                Text(fish.scienticName)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text(fish.description)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                if fish.endangeredLevel {
                                    Text("Endangered")
                                        .font(.caption)
                                        .foregroundStyle(.red)
                                }
                            }
                            Spacer()
                        }
                        .padding(.vertical, 4)
                        .background(.ultraThinMaterial)
                        .foregroundColor(.blue)
            
                        
                    }
                }
                .scrollContentBackground(.hidden) // Hide the default List background
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Fish Catalog")
            }
            
        }
        .onAppear() {
            database
        }
    }
    
}

#Preview {
    FishListView()
}

