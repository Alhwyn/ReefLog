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

struct Tag: View {
    /// this function is the tag from the species sighting it is us
    
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
    }
}


struct SightingTagView: View {
    /// this function is the tag from the species sighting wiht an additional reature that can be removed when pressed
    
    let title: String
    @Binding var fishList: [String]
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16))

            Button(action: {
                fishList.removeAll { $0 == title }
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 10)) 
                    .foregroundColor(.gray)
                    .padding(2)
            }
            .buttonStyle(PlainButtonStyle())
            
        }
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




private func groupSightings(_ sightings: [String]) -> [[String]] {
    /// this is a helper function to organize the column for the DiveModalRowView of the following Tags of the species of the DIve modal Row View
    
    var columns: [[String]] = []
    var currentColumn: [String] = []

    for fish in sightings {
        currentColumn.append(fish)

        if currentColumn.count == 3 {
            columns.append(currentColumn)
            currentColumn = []
        }
    }

    if !currentColumn.isEmpty {
        columns.append(currentColumn)
    }

    return columns
}

struct DiveModalRowView: View {
    /// The DiveModalRowView shows the nubmer of fish that can be edited when the user pressed the remove button
    /// this function is only for the dive modal when user want to create a dive log
    @Binding var fishList: [String]
    
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
                                SightingTagView(title: fish, fishList: $fishList)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}
    

struct DiveEntryRowView: View {
    /// This is  the DiveEntry Card mainy for the homescree that will show the users
    /// Location, Date of Dive, and the unique fish and species sighting duing its dive
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
                        Tag(
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
        .cornerRadius(25)
        .shadow(radius: 2)
        
    }
}
