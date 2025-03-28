//
//  FlickrLinks.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//


import Foundation

public struct FlickrLinks: Decodable, Sendable {
    public let small: [URL]
    public let original: [URL]

    public init(
        small: [URL],
        original: [URL]
    ) {
        self.small = small
        self.original = original
    }
}
