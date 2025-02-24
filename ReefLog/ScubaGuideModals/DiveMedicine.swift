//
//  DiveMedicine.swift
//  ReefLog
//
//  Created by Alhwyn Geonzon on 2025-02-23.
//
import SwiftUI

struct MedicineItems: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let icon: String // SF Symbol name
}

struct HealthCheckView: View {
    
    let HealthItems: [MedicineItems] = [
        
        MedicineItems(
            name: "A Panic induce Glotis Cramp",
            description: "HTe Glotis is a the opening in the mouth and when the water accidently enter's into the larynx you cannot breath",
            icon: "ear"
        ),
        MedicineItems(
            name: "Baratrauma of the Eyes",
            description: "Baratruama is cuased by not pressuring of the diving mask causing bleading to your eyes",
            icon: "drop.fill"
        ),
        MedicineItems(
            name: "Decompression Sickness (DCS)",
            description: "The major symptoms of DCS is signs of paralysis",
            icon: "lungs"
        ),
        MedicineItems(
            name: "Baratruama of the Sinus",
            description: "Baratruma of the sinus is when the diver forgot to equalize the sinus and can cuase sever pain in the forehead",
            icon: "figure.walk"
        ),
        MedicineItems(
            name: "Nitrogen Narcosis",
            description: "Nitrogen Narcosis is the nitrogen absorbtion to your body and can cause logical impairement and judgement impairement",
            icon: "figure.walk"
        ),
        MedicineItems(
            name: "Nitrogen Narcosis",
            description: "Nitrogen Narcosis is the nitrogen absorbtion to your body and can cause logical impairement and judgement impairement",
            icon: "figure.walk"
        )
        
    ]
    
    var body: some View {
        VStack {
            Text("Hellow world")
        }
        
        
    }
}
