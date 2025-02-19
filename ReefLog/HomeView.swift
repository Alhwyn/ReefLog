import SwiftUI


//

// Cirlce View
struct StatsCircleView: View {
    let diveCount: Int
    let speciesCount: Int
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(
                        MeshGradient(
                            width: 3,
                            height: 3,
                            points: [
                                [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                                [0.0, 0.5], [0.9, 0.3], [1.0, 0.5],
                                [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                            ],
                            colors: [
                                .white, .cyan, .blue,
                                .cyan, .cyan, .teal,
                                .teal, .teal, .green
                            ]
                        )
                    )
                
                VStack(spacing: 4) {
                    Text("\(diveCount)")
                        .font(.system(size: 40, weight: .medium))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4))
                    Text("Dives")
                        .font(.system(.title, design: .default))
                        .fontWeight(.heavy)
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4))
                }
            }
            .frame(width: 200, height: 200)
            .padding(.vertical, 20)
            
            
            
            
            Text("\(speciesCount) Fish Logged")
                .font(.system(.title3, design: .default))
                .fontWeight(.heavy)
                .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    .white, .white, .white,
                    .teal, .white, .teal,
                    .cyan, .cyan, .cyan
                ]
            )
        )
    }
}

struct HomeView: View {

    @State private var isLogging = false
    @State private var sampleEntries: [DiveEntry] = [
        DiveEntry(date: Date(), location: "Philippines Kontiki Reef", sightings: ["Thresher Shark", "Wrasse", "Clown Fish", "Green Turtle"]),
        DiveEntry(date: Date(), location: "Philippines Kontiki Reef", sightings: ["Thresher Shark", "Wrasse", "Clown Fish", "Green Turtle"]),
        DiveEntry(date: Date(), location: "Philippines Kontiki Reef", sightings: ["Thresher Shark", "Wrasse", "Clown Fish", "Green Turtle"]),

    ]
    
    var totalEntries: Int {
        sampleEntries.count
    }

    var totalSightings: Int {
        sampleEntries.reduce(0) { $0 + $1.sightings.count }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            StatsCircleView(diveCount: totalEntries, speciesCount: totalSightings)
            
            ScrollView {
                LazyVStack(spacing: 12) {
                        ForEach(sampleEntries) { entry in
                            DiveEntryRowView(entry: entry)
                                .scrollTransition(.animated.threshold(.visible(0.7))) { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1 : 0)
                                        .scaleEffect(phase.isIdentity ? 1 : 0.25)
                                        .blur(radius: phase.isIdentity ? 0 : 12)
                                }
                        }
                    }
                    .padding(.horizontal)

            }
            .background(.cyan)
            
            HStack {
                Spacer()
                Button(action: {
                    isLogging = true 
                }) {
                    Image(systemName: "fish")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .frame(width: 50, height: 50)
                        .background(.blue)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
                .padding(.trailing, 30)
                
            }
            .background(.cyan)
            .sheet(isPresented: $isLogging) {
                DiveEntryView { NewEntry  in
                    sampleEntries.append(NewEntry)
                }
            }
        
        }
      
    }
}



#Preview {
    HomeView()
}


