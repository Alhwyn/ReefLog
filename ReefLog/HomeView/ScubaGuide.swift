import SwiftUI

struct ScubaGuide: View {
    
    let cards = [
        ("Scuba Equipment", "water.waves"),
        ("Diving Medicine", "cross.case"),
        ("Diving Physics", "gauge"),
        ("Scuba Signals", "hand.raised")
    ]
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
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
                
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Scuba Guide")
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.top, 40)
                            .padding(.bottom, 10)
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(cards, id: \.0) { title, symbol in
                                NavigationLink(
                                    destination: destinationView(for: title)
                                ) {
                                    VStack(spacing: 10) {
                                        Image(systemName: symbol)
                                            .font(.system(size: 30))
                                            .foregroundColor(.white)
                                        Text(title)
                                            .font(.headline)
                                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4).opacity(0.7))
                                            .multilineTextAlignment(.center)
                                    }
                                    .frame(maxWidth: .infinity, minHeight: 120)
                                    .background(
                                        Color.white.opacity(0)
                                            .overlay(.ultraThinMaterial)
                                    )
                                    .cornerRadius(15)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
    
    // Helper function to determine the destination view
    @ViewBuilder
    private func destinationView(for title: String) -> some View {
        if title == "Scuba Equipment" {
            ScubaEquipmentView()
        } else if  title == "Diving Physics"{
            DivingPhysicsView()
        } else {
            DetailView(title: title)
        }
    }
}

struct DetailView: View {
    let title: String

    var content: String {
        switch title {
        case "Diving Medicine":
            return "Understand decompression sickness, barotrauma, and other diving-related health topics."
        case "Diving Physics":
            return "Explore pressure, buoyancy, and gas laws as they apply to scuba diving."
        case "Scuba Signals":
            return "Master hand signals like 'OK', 'Up', 'Down', and 'Stop' for underwater communication."
        default:
            return "No information available."
        }
    }
    
    var body: some View {
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
            
            VStack {
                Text(title)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                ScrollView {
                    Text(content)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ScubaGuide()
}
