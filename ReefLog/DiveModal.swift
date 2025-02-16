import SwiftUI
import PhotosUI

struct DiveEntryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var location = ""
    @State private var country = ""
    @State private var time = ""
    @State private var depth = ""
    @State private var sightingsInput = ""

    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []

    var onSave: (DiveEntry) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dive site")) {
                    TextField("Enter Location", text: $location)
                }

                Section(header: Text("Country")) {
                    TextField("Enter Country", text: $country)
                }

                Section(header: Text("Dive time")) {
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

                    // Display selected images
                    if !selectedImages.isEmpty {
                        Section(header: Text("Photo Gallery")) {
                            ScrollView(.vertical) {
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                                    ForEach(selectedImages, id: \.self) { image in
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 150, height: 150)
                                            .shadow(radius: 5)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                }
                                .padding(.vertical, 10)
                            }
                            .frame(width: 700, height: 400)
                        }
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
                        let sightings = sightingsInput
                            .split(separator: ",")
                            .map { $0.trimmingCharacters(in: .whitespaces) }

                        let newEntry = DiveEntry(date: Date(), location: location, sightings: sightings)
                        onSave(newEntry)
                        dismiss()
                    }
                    .disabled(location.isEmpty || sightingsInput.isEmpty)
                }
            }
        }
        .onChange(of: selectedItems) { newItems in
            Task {
                var images: [UIImage] = []
                for item in newItems {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        images.append(uiImage)
                    }
                }
                selectedImages = images
            }
        }
    }
}

#Preview {
    DiveEntryView(onSave: { _ in })
}

