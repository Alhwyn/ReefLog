import Foundation
import SwiftUI


struct Fish: Identifiable, Codable {
    var id = UUID()
    let scienticName: String
    let name: String
    let description: String
    let endangeredLevel: Bool
    var isFoundByUser: Bool
}


class FishDatabase: ObservableObject {
    @Published var fishList: [Fish]

    init() {
        self.fishList = [
            Fish(scienticName: "Thalassoma bifasciatum", name: "Wrasse", description: "A colorful reef fish known for its cleaning behavior.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Balistoides conspicillum", name: "Triggerfish", description: "A reef fish with a tough exterior and strong jaws.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Alopias vulpinus", name: "Thresher Shark", description: "A shark recognized by its long tail used for hunting.", endangeredLevel: true, isFoundByUser: false),
            Fish(scienticName: "Asterias rubens", name: "Starfish", description: "A marine animal with five arms that can regenerate.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Euspongia officinalis", name: "Sponge", description: "A simple aquatic animal that filters water for nutrients.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Hippocampus erectus", name: "Sea Horse", description: "A unique fish with a horse-like head and a prehensile tail.", endangeredLevel: true, isFoundByUser: false),
            Fish(scienticName: "Gorgonia ventalina", name: "Sea Fans", description: "A soft coral that forms fan-like structures.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Homo sapiens", name: "Scuba Diver", description: "A human exploring the ocean with diving gear.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Tetraodontidae", name: "Pufferfish", description: "A fish that inflates to ward off predators.", endangeredLevel: true, isFoundByUser: false),
            Fish(scienticName: "Scarus coeruleus", name: "Parrot Fish", description: "A fish that helps maintain coral reefs by eating algae.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Octopus vulgaris", name: "Octopus", description: "A highly intelligent mollusk with eight arms.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Chromodoris willani", name: "Nudibranch", description: "A colorful sea slug known for its bright colors.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Gymnothorax funebris", name: "Moray Eel", description: "A snake-like fish that hides in crevices and ambushes prey.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Manta birostris", name: "Manta Ray", description: "A large ray with distinctive wing-like fins.", endangeredLevel: true, isFoundByUser: false),
            Fish(scienticName: "Pterois volitans", name: "Lionfish", description: "A venomous fish with striking red and white stripes.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Epinephelinae", name: "Groupers", description: "Large predatory fish found in reefs and rocky areas.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Chelonia mydas", name: "Green Turtle", description: "A large sea turtle known for its herbivorous diet.", endangeredLevel: true, isFoundByUser: false),
            Fish(scienticName: "Lepidobatrachus laevis", name: "Frog Fish", description: "A camouflaged fish that ambushes its prey.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Himerometra robustipinna", name: "Feather Star", description: "A marine invertebrate with feathery arms for filter-feeding.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Lactoria cornuta", name: "Cow Fish", description: "A boxfish with distinctive horn-like structures.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Amphiprion ocellaris", name: "Clown Fish", description: "A small orange fish that forms symbiotic relationships with anemones.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Chaetodon auriga", name: "Butterfly Fish", description: "A reef fish with striking patterns and colors.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Diploria labyrinthiformis", name: "Brain Coral", description: "A coral that forms structures resembling a human brain.", endangeredLevel: false, isFoundByUser: false),
            Fish(scienticName: "Banded Sea Krait", name: "Banded Sea Snake", description: "A highly venomous sea snake with black and white bands.", endangeredLevel: true, isFoundByUser: false),
            Fish(scienticName: "Pterophyllum scalare", name: "Angel Fish", description: "A graceful fish often found in home aquariums.", endangeredLevel: false, isFoundByUser: false)
        ]
        // Sort alphabetically by `name`
        self.fishList.sort { $0.name < $1.name }
    }
}
