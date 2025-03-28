//
//  Endpoint.swift
//  RepositoryDefinitions
//
//  Created by Lucas van Dongen on 27/03/2025.
//

public struct Endpoint: Sendable {
    public let path: String
    public let version: EndpointVersion
    public let sort: [String: String]

    public init(
        path: String,
        version: EndpointVersion,
        sort: [String: String]
    ) {
        self.path = path
        self.version = version
        self.sort = sort
    }
}

public enum EndpointVersion: String, Sendable {
    case v4, v5
}
