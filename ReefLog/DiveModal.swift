import SwiftUI
import PhotosUI

struct NamedImage: Identifiable {
    let id = UUID()
    let image: UIImage
    let name: String
}


struct DiveEntryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var location = ""
    @State private var time = ""
    @State private var depth = ""
    @State private var sightingsInput = ""
    @State private var diveDate: Date = Date()
    
    @State private var fishClassifier: FishClassifierModel? = FishClassifierModel()
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [NamedImage] = []
    
    var onSave: (DiveEntry) -> Void
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
       
                    PhotoGrid(images: selectedImages)
                    
                    Section(header: Text("Scuba Photos").foregroundStyle(.primary)) {
                        PhotosPicker(selection: $selectedItems, matching: .images, photoLibrary: .shared()) {
                            Label("Add Scuba Photos", systemImage: "fish.circle")
                        }
                    }
                    
                    
                    Section(header: Text("Dive Details").foregroundStyle(.primary)) {
                        HStack {
                            Text("Date").foregroundStyle(.secondary)
                            Spacer()
                            DatePicker("", selection: $diveDate, displayedComponents: .date)
                                .labelsHidden()
                        }
                        
                        HStack {
                                Image(systemName: "clock")
                                    .foregroundStyle(.secondary)
                                TextField("Enter Dive Time", text: $time)
                            }
                        
                        HStack {
                                Image(systemName: "ruler")
                                    .foregroundStyle(.secondary)
                                TextField("Enter Depth (m)", text: $depth)
                                    .keyboardType(.decimalPad)
                            }
                    }
                    
                }
                .scrollContentBackground(.hidden)
                .background(.regularMaterial)
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
                        let sightings = selectedImages.map { $0.name }
                        let newEntry = DiveEntry(date: Date(), location: location, sightings: sightings)
                        onSave(newEntry)
                        dismiss()
                    }
                    .disabled(location.isEmpty || selectedImages.isEmpty)
                }
            }
        }
        .onChange(of: selectedItems) { oldValue, newItems in
            Task {
                var imagesWithLabels: [NamedImage] = []
                
                guard let classifier = fishClassifier else {
                    print("Fish classifier not available")
                    return
                }
   
                for item in newItems {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        let predictedFish = await classifier.classifyFish(image: uiImage)
                        imagesWithLabels.append(NamedImage(image: uiImage, name: predictedFish))

                    }
                }
                await MainActor.run {
                    selectedImages = imagesWithLabels
                }
            }
        }
        .presentationBackground(.ultraThinMaterial)
    }
    
}


#Preview {
    DiveEntryView(onSave: { _ in })
}

