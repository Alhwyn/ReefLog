import SwiftUI

struct FishListView: View {
    /// shows the list of the fish database
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
                                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4))
                                    Text(fish.scienticName)
                                        .font(.subheadline)
                                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.7))
                                    Text(fish.description)
                                        .font(.caption)
                                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.7))
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
                .foregroundStyle(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.7))
                .padding(.horizontal, 8)
                
            }
        }
    }
}

#Preview {
    FishListView()
}

