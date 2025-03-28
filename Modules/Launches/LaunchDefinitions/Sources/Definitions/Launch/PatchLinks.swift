//
//  PatchLinks.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//


import Foundation

public struct PatchLinks: Decodable, Sendable {
    public let small: URL?
    public let large: URL?

    public init(
        small: URL?,
        large: URL?
    ) {
        self.small = small
        self.large = large
    }
}
