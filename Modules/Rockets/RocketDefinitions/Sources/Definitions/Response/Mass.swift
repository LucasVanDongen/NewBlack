//
//  Mass.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//

public struct Mass: Decodable, Sendable {
    public let kg: Int
    public let lb: Int

    public init(kg: Int, lb: Int) {
        self.kg = kg
        self.lb = lb
    }
}
