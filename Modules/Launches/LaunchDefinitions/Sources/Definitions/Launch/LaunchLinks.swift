//
//  LaunchLinks.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//


import Foundation

public struct LaunchLinks: Decodable, Sendable {
    public let patch: PatchLinks?
    public let webcast: URL?
    public let article: URL?
    public let wikipedia: URL?
    public let flickr: FlickrLinks

    public init(
        patch: PatchLinks?,
        webcast: URL?,
        article: URL?,
        wikipedia: URL?,
        flickr: FlickrLinks
    ) {
        self.patch = patch
        self.webcast = webcast
        self.article = article
        self.wikipedia = wikipedia
        self.flickr = flickr
    }
}
