import SwiftUI

struct FishListView: View {
    @StateObject var database = FishDatabase()
    
    var body: some View {
        NavigationView {
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
                        Button(action: {
                            database.markAsFound(fish: fish)
                        }) {
                            Image(systemName: fish.isFoundByUser ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(fish.isFoundByUser ? .green : .gray)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Fish Catalog")
        }
        .onAppear() {
            database.loadFromUserDefaults()
        }
    }
}
