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
    @State private var diveDate: Date = Date()
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [NamedImage] = []
    @State private var fishSelectedList: [String] = []
    
    @State private var fishClassifier: FishClassifierModel? = FishClassifierModel()
    @State private var showingSightingsSheet = false
    
    var onSave: (DiveEntry) -> Void
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    PhotoGrid(images: selectedImages)
                    DiveModalRowView(fishList: $fishSelectedList)
                    
                    Section(header: Text("Scuba Photos").foregroundStyle(.primary)) {
                        PhotosPicker(selection: $selectedItems, matching: .images, photoLibrary: .shared()) {
                            Label("Add Scuba Photos", systemImage: "fish.circle")
                        }
                    }
                    
                    Button(action: {
                        showingSightingsSheet = true
                    }) {
                        Label("Add & Edit Sightings", systemImage: "plus.circle")
                            .foregroundColor(.blue)
                    }
                    
                    Section(header: Text("Dive Details").foregroundStyle(.primary)) {
                        DatePickerRow(title: "Date", date: $diveDate)
                        TextFieldRow(icon: "map.fill", placeholder: "Location", text: $location)
                        TextFieldRow(icon: "clock", placeholder: "Enter Dive Time", text: $time)
                        TextFieldRow(icon: "ruler", placeholder: "Enter Depth (m)", text: $depth, keyboardType: .decimalPad)
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
                        let newEntry = DiveEntry(date: diveDate, location: location, sightings: fishSelectedList, depth: depth, diveTime: time)
                        onSave(newEntry)
                        dismiss()
                    }
                    .disabled(location.isEmpty || fishSelectedList.isEmpty)
                }
            }
            .onChange(of: selectedItems) {
                Task { @MainActor in
                    await loadImagesAndClassify(from: selectedItems)
                }
            }
            .sheet(isPresented: $showingSightingsSheet) {
                            SightingsSheet(fishSelectedList: $fishSelectedList)
                        }
            .presentationBackground(.ultraThinMaterial)
        }
    }
    
    private func loadImagesAndClassify(from items: [PhotosPickerItem]) async {
        var imagesWithLabels: [NamedImage] = []
        
        guard let classifier = fishClassifier else {
            print("Fish classifier not available")
            return
        }
        
        for item in items {
            if let data = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                let predictedFish = await classifier.classifyFish(image: uiImage)
                imagesWithLabels.append(NamedImage(image: uiImage, name: predictedFish))
                fishSelectedList.append(predictedFish)
            }
        }
        
        selectedImages = imagesWithLabels
    }
}

struct DatePickerRow: View {
    let title: String
    @Binding var date: Date
    
    var body: some View {
        HStack {
            Text(title).foregroundStyle(.secondary)
            Spacer()
            DatePicker("", selection: $date, displayedComponents: .date)
                .labelsHidden()
        }
    }
}

struct TextFieldRow: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        HStack {
            Image(systemName: icon).foregroundStyle(.secondary)
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
        }
    }
}

struct SightingsSheet: View {
    @Binding var fishSelectedList: [String]
    @State private var customFish = ""
    @State private var fishDatabase = FishDatabase()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                
                DiveModalRowView(fishList: $fishSelectedList)
                
                Section(header: Text("Add Custom Sighting")) {
                    TextField("Enter fish name", text: $customFish)
                    Button("Add Custom Fish") {
                        let trimmedFish = customFish.trimmingCharacters(in: .whitespaces)
                        if !trimmedFish.isEmpty && !fishSelectedList.contains(trimmedFish) {
                            fishSelectedList.append(trimmedFish)
                            customFish = ""
                        }
                    }
                    .disabled(customFish.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                
                Section(header: Text("Select Fish Sightings")) {
                    ForEach(fishDatabase.fishList) { fish in
                        Button(action: {
                            if !fishSelectedList.contains(fish.name) {
                                fishSelectedList.append(fish.name)
                            }
                        }) {
                            HStack {
                                Text(fish.name) // Display only the name
                                Spacer()
                                if fishSelectedList.contains(fish.name) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Sightings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}


#Preview {
    DiveEntryView(onSave: { _ in })
}

