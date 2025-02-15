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
        ZStack {
            Circle()
                .fill(Color(red: 0.8, green: 0.9, blue: 0.9))
            
            VStack(spacing: 4) {
                Text("\(diveCount)")
                    .font(.system(size: 40, weight: .medium))
                Text("Dives")
                    .font(.system(size: 20))
                Text("\(speciesCount) Fish Logged")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 200, height: 200)
        .padding(.vertical, 20)
    }
}

struct SightingTagView: View {
    
    let title: String
    let backgroundColor: Color
    
    var body: some View {
        Text(title)
            .font(.system(size: 14))
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(backgroundColor)
            .cornerRadius(15)
            
    }
}

struct DiveEntryRowView: View {
    let entry: DiveEntry
    
    func getColorForSpecies(_ species: String) -> Color {
        switch species {
        case "Wrasse": return Color(red: 0.0, green: 0.5, blue: 1.0) // Blue
        case "Triggerfish": return Color(red: 1.0, green: 0.75, blue: 0.2) // Yellowish
        case "Thresher Shark": return Color(red: 0.3, green: 0.3, blue: 0.3) // Dark Grey
        case "Starfish": return Color(red: 0.9, green: 0.4, blue: 0.3) // Orange-red
        case "Sponge": return Color(red: 1.0, green: 0.9, blue: 0.5) // Pale Yellow
        case "Sea Horse": return Color(red: 0.9, green: 0.7, blue: 0.4) // Golden
        case "Sea Fans": return Color(red: 0.7, green: 0.3, blue: 0.7) // Purple
        case "Scuba Diver": return Color(red: 0.0, green: 0.0, blue: 0.0) // Black
        case "Pufferfish": return Color(red: 1.0, green: 0.9, blue: 0.6) // Pale Beige
        case "Parrot Fish": return Color(red: 0.0, green: 0.8, blue: 1.0) // Turquoise
        case "Octopus": return Color(red: 0.5, green: 0.0, blue: 0.5) // Deep Purple
        case "Nudibranch": return Color(red: 0.9, green: 0.2, blue: 0.5) // Bright Pinkish
        case "Moray Eel": return Color(red: 0.3, green: 0.4, blue: 0.2) // Olive Green
        case "Manta Ray": return Color(red: 0.4, green: 0.4, blue: 0.5) // Slate Grey
        case "Lionfish": return Color(red: 0.8, green: 0.3, blue: 0.2)
        case "Groupers": return Color(red: 0.5, green: 0.4, blue: 0.3) // Brownish
        case "Green Turtle": return Color(red: 0.4, green: 0.8, blue: 0.4) // Green
        case "Frog Fish": return Color(red: 0.9, green: 0.7, blue: 0.2) // Yellowish-Orange
        case "Feather Star": return Color(red: 0.9, green: 0.6, blue: 0.4) // Coral
        case "Cow Fish": return Color(red: 0.7, green: 0.6, blue: 0.3) // Mustard Yellow
        case "Clown Fish": return Color(red: 1.0, green: 0.55, blue: 0.0) // Orange
        case "Butterfly Fish": return Color(red: 1.0, green: 0.9, blue: 0.3) // Lemon Yellow
        case "Brain Coral": return Color(red: 0.8, green: 0.6, blue: 0.5) // Sandy Pink
        case "Banded Sea Snake": return Color(red: 0.1, green: 0.1, blue: 0.1)
        case "Angel Fish": return Color(red: 0.5, green: 0.7, blue: 1.0) // Light Blue  
        default: return .gray
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Date")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(entry.date, style: .date)
                        .font(.system(size: 16))
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Location")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(entry.location)
                        .font(.system(size: 16))
                }
                
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Sightings")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                FlowLayout(spacing: 4) {
                    ForEach(entry.sightings, id: \.self) { species in
                        SightingTagView(
                            title: species,
                            backgroundColor: getColorForSpecies(species)
                        )
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, y: 1)
        
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
    @State private var sampleEntries: [DiveEntry] = [
        DiveEntry(date: Date(), location: "Philippines Kontiki Reef", sightings: ["Thresher Shark", "Wrasse"]),
        DiveEntry(date: Date(), location: "Philippines Kontiki Reef", sightings: ["Thresher Shark", "Wrasse", "Clown Fish", "Green Turtle"]),
        DiveEntry(date: Date(), location: "Malapascua Island", sightings: ["Thresher Shark", "Green Turtle"])
    ]
    
    @State private var isLogging = false
    
    var totalEntries: Int {
        sampleEntries.count
    }

    var totalSightings: Int {
        sampleEntries.reduce(0) { $0 + $1.sightings.count }
    }
    

    
    var body: some View {
        VStack {
            StatsCircleView(diveCount: totalEntries, speciesCount: totalSightings)
            
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(sampleEntries) { entry in
                        DiveEntryRowView(entry: entry)
                        
                    }
                }
                .padding(.horizontal)
            }
            
            HStack {
                Spacer()
                Button(action: {
                    isLogging = true 
                }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .frame(width: 50, height: 50)
                        .background(Color(red: 0.8, green: 0.9, blue: 0.9))
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
                .padding(.trailing, 30)
            }
            .background(Color(white: 0.95))
            .navigationTitle("My Dives")
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


