//
//  DiveEntryRowView.swift
//  ReefLog
//
//  Created by Alhwyn Geonzon on 2025-02-18.
//
import SwiftUI

struct DiveEntry: Identifiable {
    let id = UUID()
    let date: Date
    let location: String
    let sightings: [String]
    let depth: String
    let diveTime: String
}



struct SightingTagView: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 16))
            .foregroundStyle(Color(red: 0.0, green: 0.2, blue: 0.4))
            .padding(.horizontal, 14)
            .padding(.vertical, 7)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.teal.opacity(0.3))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
    }
}


struct DiveModalRowView: View {
    let fishList: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Sightings")
                .font(.caption)
                .foregroundColor(.gray)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 8) {
                    ForEach(groupSightings(fishList), id: \.self) { column in
                        VStack(spacing: 4) {
                            ForEach(column, id: \.self) { fish in
                                SightingTagView(title: fish)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }

    /// Groups the fish list into columns with a max of 3 rows per column
    private func groupSightings(_ sightings: [String]) -> [[String]] {
        var columns: [[String]] = []
        var currentColumn: [String] = []

        for fish in sightings {
            currentColumn.append(fish)

            if currentColumn.count == 3 { // Limit to 3 per column
                columns.append(currentColumn)
                currentColumn = []
            }
        }

        if !currentColumn.isEmpty { // Add remaining fish
            columns.append(currentColumn)
        }

        return columns
    }
}



struct DiveEntryRowView: View {
    let entry: DiveEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Date")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(entry.date, style: .date)
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4))
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Location")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(entry.location)
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.4))
                    
                }
                
            }
            
            VStack(alignment: .leading, spacing: 4) {
                
                FlowLayout(spacing: 4) {
                    ForEach(entry.sightings, id: \.self) { species in
                        SightingTagView(
                            title: species
                        )
                    }
                }
            }
        }
        .padding()
        .background(
            Color.white.opacity(0.2)
                .overlay(.ultraThinMaterial)
        )
        .cornerRadius(12)
        .shadow(radius: 2)
        
    }
}
