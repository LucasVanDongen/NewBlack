//
//  PayloadWeight.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//

public struct PayloadWeight: Decodable, Identifiable, Sendable {
    public let id: String
    public let name: String
    public let kg: Int
    public let lb: Int

    public init(
        id: String,
        name: String,
        kg: Int,
        lb: Int
    ) {
        self.id = id
        self.name = name
        self.kg = kg
        self.lb = lb
    }
}
