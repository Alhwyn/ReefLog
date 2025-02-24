import SwiftUI

struct StatsCircleView: View {
    let diveCount: Int
    let speciesCount: Int
    let maxDepth: Int
    let totalTime: Int
    
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
                        .font(.system(size: 80, weight: .medium))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4))
                    Text("Dives")
                        .fontWeight(.heavy)
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.7))
                }
            }
            .frame(width: 200, height: 200)
            .padding(.vertical, 10)
            
            HStack {
                HStack(spacing: 10) {
                    Image(systemName: "fish")
                        .font(.system(size: 40))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4))
                        VStack(spacing: 6) {
                            Text("\(speciesCount)")
                                .font(.system(size: 30, design: .rounded))
                                .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4))
                            Text("Fish Logged")
                                .font(.system(size: 12, design: .rounded))
                                .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.7))
                    }
                }
                .frame(width: 170, height: 80)
                .background(
                    Color.white.opacity(0.2)
                        .overlay(.ultraThinMaterial)
                )
                .cornerRadius(20)
                .shadow(radius: 2)
                
                VStack(spacing: 6) {
                    Text("\(maxDepth)")
                        .font(.system(size: 30, design: .rounded))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4))
                    Text("Max Depth")
                        .font(.system(size: 12, design: .rounded))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.7))
                }
                .frame(width: 80, height: 80)
                .background(
                    Color.white.opacity(0.2)
                        .overlay(.ultraThinMaterial)
                )
                .cornerRadius(15)
                .shadow(radius: 2)
             
            
                
                VStack(spacing: 6) {
                    Text("\(totalTime)")
                        .font(.system(size: 30, design: .rounded))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4))
                    Text("Total Time ")
                        .font(.system(size: 12, design: .rounded))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.7))
                }
                .frame(width: 80, height: 80)
                .background(
                    Color.white.opacity(0.2)
                        .overlay(.ultraThinMaterial)
                )
                .cornerRadius(15)
                .shadow(radius: 2)
     
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
    
    var totalDiveTime: Int {
        sampleEntries.reduce(0) { total, entry in
            if let time = Int(entry.diveTime) { // Convert string to int, ignore if not a digit
                return total + time
            }
            return total // Ignore non-numeric values
        }
    }
    
    var maximumDepth: Int {
        sampleEntries.map { entry in
            Int(entry.depth) ?? 0 // Convert string to int, use 0 if not a digit
        }.max() ?? 0 // Return max value, or 0 if array is empty
    }
    
    var body: some View {
        ZStack {
            Color.teal
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                StatsCircleView(diveCount: totalEntries, speciesCount: totalSightings, maxDepth: maximumDepth, totalTime: totalDiveTime)
                
                ScrollView {
                    if sampleEntries.isEmpty {
                        VStack(spacing: 10) {
                            Text("Empty Dive Log")
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
                    .padding(.trailing, 35)
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


