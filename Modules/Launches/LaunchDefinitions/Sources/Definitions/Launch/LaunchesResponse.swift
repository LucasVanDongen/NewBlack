//
//  LaunchesResponse.swift
//  RocketDefinitions
//
//  Created by Lucas van Dongen on 26/03/2025.
//


import Foundation

import RepositoryDefinitions

public extension PaginatedResponse {
    var docs: [T] { items }
}

public struct LaunchesResponse: Decodable {
    public let docs: [Launch]
    public let totalDocs: Int
    public let limit: Int
    public let totalPages: Int
    public let page: Int
    public let pagingCounter: Int
    public let hasPrevPage: Bool
    public let hasNextPage: Bool
    public let prevPage: Int?
    public let nextPage: Int?

    public init(
        docs: [Launch],
        totalDocs: Int,
        limit: Int,
        totalPages: Int,
        page: Int,
        pagingCounter: Int,
        hasPrevPage: Bool,
        hasNextPage: Bool,
        prevPage: Int?,
        nextPage: Int?
    ) {
        self.docs = docs
        self.totalDocs = totalDocs
        self.limit = limit
        self.totalPages = totalPages
        self.page = page
        self.pagingCounter = pagingCounter
        self.hasPrevPage = hasPrevPage
        self.hasNextPage = hasNextPage
        self.prevPage = prevPage
        self.nextPage = nextPage
    }
}
