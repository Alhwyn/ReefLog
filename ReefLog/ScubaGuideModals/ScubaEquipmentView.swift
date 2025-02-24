import SwiftUI

struct EquipmentItem: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let icon: String
}


struct ScubaEquipmentView: View {
    let equipmentItems: [EquipmentItem] = [
        EquipmentItem(
            name: "Snorkel",
            description: "Snorkel has a very fixed length of 35cm long and 18-25mm in diameter",
            icon: "wind"
        ),
        EquipmentItem(
            name: "Weight Belt",
            description: "A weight belt must be fitted with a quick release buckle",
            icon: "scalemass"
        ),
        EquipmentItem(
            name: "Regulator",
            description: "The regulator delivers air from the tank to the diver, allowing breathing underwater. It consists of a first stage (connects to the tank) and a second stage (mouthpiece).",
            icon: "wind"
        ),
        EquipmentItem(
            name: "BCD (Buoyancy Control Device)",
            description: "The BCD helps divers control their buoyancy by inflating or deflating it with air. It also holds the tank securely on the diver’s back.",
            icon: "water.waves"
        ),
        EquipmentItem(
            name: "Dive Mask",
            description: "The dive mask allows clear vision underwater by creating an air pocket over the eyes. It must fit snugly to prevent leaks.",
            icon: "eye"
        ),
        EquipmentItem(
            name: "Fins",
            description: "Fins enhance swimming efficiency, propelling divers through the water with less effort. They come in various styles like open-heel or full-foot.",
            icon: "figure.pool.swim"
        ),
        EquipmentItem(
            name: "Tank",
            description: "The scuba tank holds compressed air or a gas mixture (like nitrox) for breathing underwater. Typically made of steel or aluminum.",
            icon: "cylinder"
        )
    ]
    
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
            

            TabView {
                ForEach(equipmentItems) { item in
                    VStack(spacing: 20) {
                        Image(systemName: item.icon)
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                            .padding(.top, 50)
                        
                        Text(item.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Text(item.description)
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }
}

#Preview {
    ScubaEquipmentView()
}
