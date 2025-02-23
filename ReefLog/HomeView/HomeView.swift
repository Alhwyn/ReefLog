import SwiftUI


//

// Cirlce View
struct StatsCircleView: View {
    let diveCount: Int
    let speciesCount: Int
    //let maxDepth: Int
    
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
                        ).opacity(0.4)
                    )
                
                VStack(spacing: 0) {
                    Text("\(diveCount)")
                        .font(.system(size: 80, weight: .light))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4))
                    Text("Dives")
                        .fontWeight(.heavy)
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4))
                }
            }
            .frame(width: 200, height: 200)
            .padding(.vertical, 10)
            
            HStack {
                HStack(spacing: 10) {
                    Image(systemName: "fish")
                        .font(.system(size: 40))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.7))
                        VStack(spacing: 6) {
                            Text("\(speciesCount)")
                                .font(.system(size: 30, weight: .bold, design: .default))
                                .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.7))
                            Text("Fish Logged")
                                .font(.system(size: 12, weight: .medium, design: .default))
                                .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.7))
                    }
                }
                .frame(width: 170, height: 90)
                .background(
                    Color.teal.opacity(0.2)
                        .overlay(.ultraThinMaterial)
                )
                .cornerRadius(20)
                .shadow(color: .teal.opacity(0.1), radius: 5, x: 0, y: 2)
                
                VStack(spacing: 6) {
                    Text("79m")
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.7))
                    Text("Maximum Depth")
                        .font(.system(size: 12, weight: .medium, design: .default))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.7))
                }
                .frame(width: 90, height: 90)
                .background(
                    Color.teal.opacity(0.2)
                        .overlay(.ultraThinMaterial)
                )
                .cornerRadius(20)
                .shadow(color: .teal.opacity(0.1), radius: 5, x: 0, y: 2)
            
                
                VStack(spacing: 6) {
                    Text("40h")
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.7))
                    Text("Total Underwater")
                        .font(.system(size: 12, weight: .medium, design: .default))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.7))
                }
                .frame(width: 90, height: 90)
                .background(
                    Color.teal.opacity(0.2)
                        .overlay(.ultraThinMaterial)
                )
                .cornerRadius(20)
                .shadow(color: .teal.opacity(0.1), radius: 5, x: 0, y: 2)
            }

            

            
            
    
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
                    .teal, .teal, .teal,
                    .teal, .white, .teal,
                    .cyan, .cyan, .cyan
                ]
            )
        )
    }
}

struct HomeView: View {

    @State private var isLogging = false
    @State private var sampleEntries: [DiveEntry] = []
    
    var totalEntries: Int {
        sampleEntries.count
    }

    var totalSightings: Int {
        sampleEntries.reduce(0) { $0 + $1.sightings.count }
    }
    
    var body: some View {
        ZStack {
            Color.teal
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                StatsCircleView(diveCount: totalEntries, speciesCount: totalSightings)
                
                ScrollView {
                    if sampleEntries.isEmpty {
                        VStack(spacing: 10) {
                            Text("No Fish Found")
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
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
                }
                
                .background(.cyan)
                
                HStack {
                    Spacer()
                    Button(action: {
                        isLogging = true
                    }) {
                        Image(systemName: "plus")
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
                    DiveEntryView { NewEntry in
                        sampleEntries.append(NewEntry)
                    }
                }
            }
        }
    }
}



#Preview {
    HomeView()
}


