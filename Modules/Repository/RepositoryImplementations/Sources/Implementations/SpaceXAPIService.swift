//
//  SpaceXAPIService.swift
//  RepositoryImplementations
//
//  Created by Lucas van Dongen on 25/03/2025.
//

import Foundation
import RepositoryDefinitions

// Continuing SpaceXAPIService implementation
public class SpaceXAPIService: APIService {
    private let baseURL = "https://api.spacexdata.com"
    private let session: URLSession
    private let decoder: JSONDecoder

    public init(session: URLSession = .shared) {
        self.session = session
        self.decoder = JSONDecoder()

        // Configure decoder for snake_case to camelCase conversion
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        decoder.dateDecodingStrategy = .custom { decoder in
            // Configure date decoding
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            if let date = dateFormatter.date(from: dateString) {
                return date
            }

            // Fallback to date-only format if the full format fails
            dateFormatter.formatOptions = [.withFullDate]
            if let date = dateFormatter.date(from: dateString) {
                return date
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Cannot decode date: \(dateString)"
            )
        }

        // Handle URLs
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(
            positiveInfinity: "Infinity",
            negativeInfinity: "-Infinity",
            nan: "NaN"
        )
    }

    public func fetchItems<T: Decodable>(endpoint: Endpoint, page: Int, limit: Int) async throws -> PaginatedResponse<T> {
        // Create request body with pagination
        let requestBody: [String: Any] = [
            "query": [:],
            "options": [
                "page": page,
                "limit": limit,
                "sort": endpoint.sort
            ]
        ]

        // Determine API version based on endpoint
        let url = URL(string: "\(baseURL)/\(endpoint.version)/\(endpoint.path)/query")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)

        // Fetch data with URLCache support
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        // Decode API response
        let apiResponse = try decoder.decode(APIResponse<T>.self, from: data)

        // Convert to our PaginatedResponse format
        return PaginatedResponse(
            items: apiResponse.docs,
            page: apiResponse.page,
            totalPages: apiResponse.totalPages,
            hasNextPage: apiResponse.hasNextPage
        )
    }

    public func fetchItem<T: Decodable>(endpoint: Endpoint, id: String) async throws -> T {
        // Determine API version based on endpoint
        let url = URL(string: "\(baseURL)/\(endpoint.version)/\(endpoint.path)/\(id)")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Fetch data with URLCache support
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        // Decode single item response
        return try decoder.decode(T.self, from: data)
    }

    // API response structure that matches SpaceX API pagination format
    private struct APIResponse<T: Decodable>: Decodable {
        let docs: [T]
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
}
