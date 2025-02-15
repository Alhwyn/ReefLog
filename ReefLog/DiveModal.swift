//
//  DiveModal.swift
//  ReefLog
//
//  Created by Alhwyn Geonzon on 2025-02-09.
//
import SwiftUI

struct DiveEntryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var location = ""
    @State private var country = ""
    @State private var time = ""
    @State private var depth = ""
    @State private var sightingsInput = ""
    
    var onSave: (DiveEntry) -> Void
    
    var body: some View {
        NavigationView {
            Form {
             
                Section(header: Text("Dive site")) {
                    TextField("Enter Location", text: $location)
                
                }
                
                Section(header: Text("Country")) {
                    TextField("Enter Location", text: $country)
    
                }
                Section(header: Text("Dive time")) {
                    TextField("Enter Location", text: $time)
                }
                
                Section(header: Text("Depth")) {
                    TextField("Enter Location", text: $depth)
                }
                
                Section(header: Text("Fish Sighting")) {
                    TextField("Enter sighting (comma-seperated)", text: $sightingsInput)
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
    }
}


#Preview {
    DiveEntryView(onSave: { _ in })
}
