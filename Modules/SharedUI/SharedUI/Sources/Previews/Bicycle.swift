//
//  Bicycle.swift
//  SharedUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI

/// A fake data type to test the generic Views without loading actual Rockets or Launches
struct Bicycle: Identifiable {
    let id: String
    let brand: String
    let model: String
    let color: Color
}

extension Bicycle {
    static let babboe = Bicycle(id: "1", brand: "Babboe", model: "Cargo Bike", color: .brown)
    static let trek = Bicycle(id: "2", brand: "Trek", model: "Mountain Bike", color: .yellow)
    static let giant = Bicycle(id: "3", brand: "Giant", model: "Racing Bike", color: .blue)
}
