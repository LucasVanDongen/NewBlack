//
//  RocketsResponse.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//

struct RocketsResponse: Decodable {
    let docs: [Rocket]
    let totalDocs: Int
    let limit: Int
    let totalPages: Int
    let page: Int
    let pagingCounter: Int
    let hasPrevPage: Bool
    let hasNextPage: Bool
    let prevPage: Int?
    let nextPage: Int?
}
