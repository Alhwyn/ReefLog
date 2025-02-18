import SwiftUI

struct DiveEntry: Identifiable {
    let id = UUID()
    let date: Date
    let location: String
    let sightings: [String]
}

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

struct SightingTagView: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 16)) // Bolder font
            .foregroundStyle(Color(red: 0.0, green: 0.2, blue: 0.4))
            .padding(.horizontal, 14)
            .padding(.vertical, 7)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.teal.opacity(0.3))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1) // Soft border
            )
    }
}

struct DiveEntryRowView: View {
    let entry: DiveEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Date")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(entry.date, style: .date)
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4))
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Location")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(entry.location)
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4))
                    
                }
                
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Sightings")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                FlowLayout(spacing: 4) {
                    ForEach(entry.sightings, id: \.self) { species in
                        SightingTagView(
                            title: species
                        )
                    }
                }
            }
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(12)
        .shadow(radius: 2)
        
    }
}
    
struct FlowLayout: Layout {
    
    var spacing: CGFloat = 4
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.width ?? 0, subviews: subviews, spacing: spacing)
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout()) {
        let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
        for row in result.rows {
            for element in row.elements {
                element.view.place(
                    at: CGPoint(x: bounds.minX + element.x, y: bounds.minY + row.y),
                    proposal: ProposedViewSize(element.size)
                )
            }
        }
    }
}

struct FlowResult {
    var size: CGSize
    var rows: [Row]
    
    struct Row {
        var y: CGFloat
        var height: CGFloat
        var elements: [Element]
        
    }
    
    struct Element {
        var x: CGFloat
        var size: CGSize
        var view: LayoutSubview
        
    }
    
    init(in width: CGFloat, subviews: LayoutSubviews, spacing: CGFloat) {
        var rows: [Row] = []
        var currentRow  = Row(y: 0, height: 0, elements: [])
        var x: CGFloat = 0
        var y: CGFloat = 0
        var maxWidth: CGFloat = 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            
            if x + size.width > width && !currentRow.elements.isEmpty {
                rows.append(currentRow)
                y += currentRow.height + spacing
                x = 0
                currentRow = Row(y: y, height: 0, elements: [])
                
            }
            currentRow.elements.append(Element(x: x, size: size, view: subview))
            currentRow.height = max(currentRow.height, size.height)
            x += size.width + spacing
            maxWidth = max(maxWidth, x)
        }
        
        if !currentRow.elements.isEmpty {
            rows.append(currentRow)
            y += currentRow.height
        }
        
        self.rows = rows
        self.size = CGSize(width: maxWidth, height: y)
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


