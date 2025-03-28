//
//  EngineInfo.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//

public struct EngineInfo: Decodable, Sendable {
    public  let number: Int
    public  let type: String
    public  let version: String?
    public  let layout: String?
    public  let propellant1: String
    public  let propellant2: String

    public init(
        number: Int,
        type: String,
        version: String? = nil,
        layout: String? = nil,
        propellant1: String,
        propellant2: String
    ) {
        self.number = number
        self.type = type
        self.version = version
        self.layout = layout
        self.propellant1 = propellant1
        self.propellant2 = propellant2
    }
}
