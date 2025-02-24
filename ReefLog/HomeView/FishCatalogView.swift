import SwiftUI

struct FishListView: View {
    @StateObject var database = FishDatabase()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
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
                

                List {
                    ForEach(database.fishList) { fish in
                        ZStack {
                            // Glass effect for each row
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.thinMaterial)

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
                            .padding()
                        }
                        .listRowBackground(Color.clear)
                        .padding(.vertical, 4)
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Fish Catalog")
                .padding(.horizontal, 8)
                .foregroundStyle(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.7))
            }
        }
    }
}

#Preview {
    FishListView()
}

