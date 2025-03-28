//
//  RocketDetailContent.swift
//  RocketUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI

import RocketDefinitions
import SharedUI

struct RocketDetailContent: View {
    let rocket: Rocket
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header with image carousel
                ImageCarousel(imageURLs: rocket.flickrImages)
                    .aspectRatio(16/9, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 4)
                
                VStack(alignment: .leading, spacing: 12) {
                    // Title and type
                    HStack {
                        VStack(alignment: .leading) {
                            Text(rocket.name)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text(rocket.type)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        // Active status badge
                        StatusBadge(isActive: rocket.active)
                    }
                    
                    Divider()
                    
                    // Description
                    Text(rocket.description)
                        .font(.body)
                        .padding(.vertical, 4)
                    
                    // Specs section
                    SpecsSection(title: "Specifications") {
                        SpecRow(title: "First Flight", value: DateFormatter.formatted(date: rocket.firstFlight))
                        SpecRow(title: "Success Rate", value: "\(rocket.successRatePct)%")
                        SpecRow(title: "Cost Per Launch", value: NumberFormatter.formatted(currency: rocket.costPerLaunch))
                        SpecRow(title: "Height", value: formatDimension(rocket.height, unit: "m/ft"))
                        SpecRow(title: "Diameter", value: formatDimension(rocket.diameter, unit: "m/ft"))
                        SpecRow(title: "Mass", value: formatMass(rocket.mass))
                    }
                    
                    // Engine section
                    SpecsSection(title: "Engines") {
                        SpecRow(title: "Number", value: "\(rocket.engines.number)")
                        SpecRow(title: "Type", value: rocket.engines.type)
                        if let version = rocket.engines.version {
                            SpecRow(title: "Version", value: version)
                        }
                        SpecRow(title: "Propellants", value: "\(rocket.engines.propellant1)/\(rocket.engines.propellant2)")
                    }
                    
                    // Stage information
                    SpecsSection(title: "First Stage") {
                        SpecRow(title: "Reusable", value: rocket.firstStage.reusable ? "Yes" : "No")
                        if let engines = rocket.firstStage.engines {
                            SpecRow(title: "Engines", value: "\(engines)")
                        }
                        if let fuelAmount = rocket.firstStage.fuelAmountTons {
                            SpecRow(title: "Fuel Amount", value: "\(fuelAmount) tons")
                        }
                        if let burnTime = rocket.firstStage.burnTimeSec {
                            SpecRow(title: "Burn Time", value: "\(burnTime) sec")
                        }
                    }
                    
                    SpecsSection(title: "Second Stage") {
                        SpecRow(title: "Reusable", value: rocket.secondStage.reusable ? "Yes" : "No")
                        if let engines = rocket.secondStage.engines {
                            SpecRow(title: "Engines", value: "\(engines)")
                        }
                        if let fuelAmount = rocket.secondStage.fuelAmountTons {
                            SpecRow(title: "Fuel Amount", value: "\(fuelAmount) tons")
                        }
                        if let burnTime = rocket.secondStage.burnTimeSec {
                            SpecRow(title: "Burn Time", value: "\(burnTime) sec")
                        }
                    }
                    
                    // Wikipedia link if available
                    if let wikipediaURL = rocket.wikipedia {
                        Link(destination: wikipediaURL) {
                            HStack {
                                Text("Read more on Wikipedia")
                                Image(systemName: "arrow.up.right")
                            }
                            .font(.subheadline)
                            .padding(.vertical, 8)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Rocket Details")
    }
    
    private func formatDimension(_ dimension: RocketDefinitions.Dimension, unit: String) -> String {
        let meters = dimension.meters ?? 0
        let feet = dimension.feet ?? 0
        return String(format: "%.1f/%.1f \(unit)", meters, feet)
    }
    
    private func formatMass(_ mass: RocketDefinitions.Mass) -> String {
        return "\(mass.kg) kg / \(mass.lb) lb"
    }
}
