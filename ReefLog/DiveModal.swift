import SwiftUI
import PhotosUI
import Vision
import CoreML


struct NamedImage: Identifiable {
    let id = UUID() // Unique identifier
    let image: UIImage
    let name: String
}


struct DiveEntryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var location = ""
    @State private var country = ""
    @State private var time = ""
    @State private var depth = ""
    @State private var sightingsInput = ""
    
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [NamedImage] = [] // Store image + name
    
    var onSave: (DiveEntry) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dive Site")) {
                    TextField("Enter Location", text: $location)
                }
                
                Section(header: Text("Country")) {
                    TextField("Enter Country", text: $country)
                }
                
                Section(header: Text("Dive Time")) {
                    TextField("Enter Time", text: $time)
                }
                
                Section(header: Text("Depth")) {
                    TextField("Enter Depth", text: $depth)
                }
                
                Section(header: Text("Fish Sighting")) {
                    TextField("Enter sighting (comma-separated)", text: $sightingsInput)
                }
                
                Section(header: Text("Add Photos")) {
                    PhotosPicker(selection: $selectedItems, matching: .images, photoLibrary: .shared()) {
                        Label("Select Photos", systemImage: "photo.on.rectangle.angled")
                    }
                }
                
                // **Scuba Photos Section**
                if !selectedImages.isEmpty {
                    Section(header: Text("Scuba Photos").font(.headline)) {
                        PhotoGrid(images: selectedImages)
                    }
                }
            }
            .navigationTitle("Dive Log")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let sightings = selectedImages.map { $0.name } // Get classified fish names
                        let newEntry = DiveEntry(date: Date(), location: location, sightings: sightings)
                        onSave(newEntry)
                        dismiss()
                    }
                    .disabled(location.isEmpty || selectedImages.isEmpty)
                }
            }
        }
        .onChange(of: selectedItems) { oldValue, newItems in
            Task<Void, Never> {  // Explicitly specify the Task type
                var imagesWithLabels: [NamedImage] = []
                for item in newItems {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        let resizedImage = uiImage.resized(to: CGSize(width: 800, height: 800))
                        let predictedFish = await classifyFish(image: resizedImage)
                        imagesWithLabels.append(NamedImage(image: resizedImage, name: predictedFish))
                    }
                }
                await MainActor.run {
                    selectedImages = imagesWithLabels
                }
            }
        }
    }
    func classifyFish(image: UIImage) async -> String {
        // Resize image to reduce memory pressure
        do {
            let config = MLModelConfiguration()
            let mlModel = try FishClassifier(configuration: config)
            let model = try VNCoreMLModel(for: mlModel.model)
            
            return await withCheckedContinuation { continuation in
                var hasResumed = false // Flag to ensure continuation is resumed only once
                
                let request = VNCoreMLRequest(model: model) { request, error in
                    defer {
                        if !hasResumed {
                            continuation.resume(returning: "Unknown") // Ensure continuation is always resumed
                            hasResumed = true
                        }
                    }
                    
                    if let error = error {
                        print("Vision error: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let results = request.results as? [VNClassificationObservation],
                          !results.isEmpty else {
                        return
                    }
                    
                    continuation.resume(returning: results[0].identifier)
                    hasResumed = true
                }
                
                guard let ciImage = CIImage(image: image) else {
                    continuation.resume(returning: "Unknown")
                    hasResumed = true
                    return
                }
                
                let handler = VNImageRequestHandler(ciImage: ciImage)
                do {
                    try handler.perform([request])
                } catch {
                    print("Error performing Vision request: \(error)")
                }
            }
        } catch {
            print("Error initializing ML model: \(error)")
            return "Unknown"
        }
    }
}


extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

#Preview {
    DiveEntryView(onSave: { _ in })
}

