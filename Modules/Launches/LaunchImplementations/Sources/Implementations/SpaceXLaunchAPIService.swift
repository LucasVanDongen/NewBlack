//
//  SpaceXLaunchAPIService.swift
//  LaunchImplementations
//
//  Created by Lucas van Dongen on 27/03/2025.
//

import Foundation

import LaunchDefinitions
import RepositoryDefinitions

public class SpaceXLaunchAPIService: LaunchAPIService {
    private let baseURL = "https://api.spacexdata.com"
    private let session: URLSession
    private let decoder: JSONDecoder

    public init(session: URLSession = .shared) {
        self.session = session
        self.decoder = JSONDecoder()

        // Configure decoder for snake_case to camelCase conversion
        decoder.keyDecodingStrategy = .convertFromSnakeCase


        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            // Configure date decoding
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            if let date = dateFormatter.date(from: dateString) {
                return date
            }

            // Fallback to date-only format
            dateFormatter.formatOptions = [.withFullDate]
            if let date = dateFormatter.date(from: dateString) {
                return date
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Cannot decode date: \(dateString)"
            )
        }
    }

    public func fetchLaunch(id: String) async throws -> Launch {
        let url = URL(string: "\(baseURL)/v5/launches/\(id)")!

        let request = URLRequest(url: url)
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try decoder.decode(Launch.self, from: data)
    }

    public func fetchLaunches(startDate: Date? = nil, endDate: Date? = nil, page: Int = 1, limit: Int = 10) async throws -> PaginatedResponse<Launch> {
        let url = URL(string: "\(baseURL)/v5/launches/query")!

        // Build query
        var query: [String: Any] = [:]
        var dateQuery = [String: String]()
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        // Add date filter if dates are provided
        if let startDate {
            dateQuery["$gte"] = formatter.string(from: startDate)
        }

        // Add date filter if dates are provided
        if let endDate {
            dateQuery["$lte"] = formatter.string(from: endDate)
        }

        // Add date filter if dates are provided
        if startDate != nil || endDate != nil {
            query["date_utc"] = dateQuery
        }

        // Create request body
        let requestBody: [String: Any] = [
            "query": query,
            "options": [
                "page": page,
                "limit": limit,
                "sort": ["date_utc": "desc"],
                "populate": ["rocket", "launchpad"]
            ]
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let apiResponse = try decoder.decode(LaunchesResponse.self, from: data)

        return PaginatedResponse(
            items: apiResponse.docs,
            page: apiResponse.page,
            totalPages: apiResponse.totalPages,
            hasNextPage: apiResponse.hasNextPage
        )
    }
}
