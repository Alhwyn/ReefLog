import Foundation
import SwiftUI


struct Fish: Identifiable, Codable {
    let id = UUID()
    let scienticName: String
    let name: String
    let description: String
    let endangeredLevel: Bool
    var isFoundByUser: Bool
}


class FishDatabase: ObservableObject {
    @Published var fishList: [Fish] = [
        Fish(scienticName: "Chelonia mydas",
             name: "Green Turtle",
             description: "A large sea turtle that primarily feeds on seagrass.",
             endangeredLevel: true,
             isFoundByUser: false),
        Fish(scienticName: "Alopias pelagicus",
             name: "Thresher Shark",
             description: "A deep-sea shark known for its long tail.",
             endangeredLevel: true,
             isFoundByUser: false),
        Fish(scienticName: "Amphiprioninae",
             name: "Clown Fish",
             description: "A small, brightly colored fish that lives in anemones.",
             endangeredLevel: true,
             isFoundByUser: false),
        Fish(scienticName: "Labridae",
             name: "Wrasse",
             description: "A diverse family of fish often found in coral reefs.",
             endangeredLevel: true,
             isFoundByUser: true)
    ]
    
    
    func markAsFound(fish: Fish) {
        if let index = fishList.firstIndex(where: { $0.id == fish.id}) {
            fishList[index].isFoundByUser = true
            saveToUserDefaults()
        }
    }

    func saveToUserDefaults() {
            if let encoded = try? JSONEncoder().encode(fishList) {
                UserDefaults.standard.set(encoded, forKey: "fishList")
            }
        }

    func loadFromUserDefaults() {
            if let savedData = UserDefaults.standard.data(forKey: "fishList"),
               let decoded = try? JSONDecoder().decode([Fish].self, from: savedData) {
                fishList = decoded
            }
        }

}


