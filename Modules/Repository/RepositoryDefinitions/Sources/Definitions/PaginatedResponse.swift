//
//  PaginatedResponse.swift
//  RepositoryDefinitions
//
//  Created by Lucas van Dongen on 25/03/2025.
//

import Foundation

public struct PaginatedResponse<T: Decodable> {
    public let items: [T]
    public let page: Int
    public let totalPages: Int
    public let hasNextPage: Bool
    
    public init(items: [T], page: Int, totalPages: Int, hasNextPage: Bool) {
        self.items = items
        self.page = page
        self.totalPages = totalPages
        self.hasNextPage = hasNextPage
    }
}
