//
//  Test.swift
//  RepositoryImplementations
//
//  Created by Lucas van Dongen on 25/03/2025.
//

import Testing

@testable import RepositoryDefinitions
@testable import RepositoryImplementations

public struct Rocket: SpaceXModel {
    public let id: String
    public let name: String
    public let type: String
    public let active: Bool
    public let stages: Int
}

public struct Launch: SpaceXModel {
    public let id: String
    public let name: String
    public let flightNumber: Int
}

struct Test {
    @Test
    func realAPICall() async throws {
        let rockets: PaginatedResponse<Rocket> = try await SpaceXAPIService().fetchItems(endpoint: "rockets", page: 1, limit: 10)

        #expect(rockets.items.count > 0)
    }

    @Test
    func realAPICall2() async throws {
        let rockets: PaginatedResponse<Launch> = try await SpaceXAPIService().fetchItems(endpoint: "launches", page: 1, limit: 10)

        #expect(rockets.items.count > 0)
    }
}
