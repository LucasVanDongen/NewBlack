# SpaceX Info App - Requirements

## Objective
Develop an iOS app that provides information about SpaceX launches and rockets using the [SpaceX API](https://github.com/r-spacex/SpaceX-API). The app should be user-friendly and adhere to basic app design principles. Your project must compile using the latest version of Xcode.

## App Features & Requirements

### 1. Bottom Navigation Bar
- Implement a SwiftUI TabView with two tabs:
 - **Launches**: Displays a list of past and upcoming launches
 - **Rockets**: Lists SpaceX rockets with specifications (optional)
- Ensure smooth navigation between tabs
- Icons should be visually distinct and clearly represent each section

### 2. Launches
- Implement a list of launches displaying:
 - Mission name
 - Launch site
 - Launch date
 - Launch status
- The list should be paginated and include a filter based on the launch date (interval start-end)
- When a user selects a launch, navigate to a **detailed view**

### 3. Launch Details Screen
- Display launch details, including:
 - Launch description
 - Image
 - Launch site
 - Date
 - Launch success status
 - A link to watch the launch
- Display a card showing the **rocket name and type**
- Tapping this card should navigate to the **Rocket Details Screen**

### 4. Rockets (optional)
- Implement a list displaying SpaceX rockets, including:
 - Image
 - Name
 - Type
 - Success rate
- When a user selects a rocket, navigate to a **detailed view**
- The list should be **paginated**

### 5. Rocket Details Screen
- Display rocket details, including:
 - Image
 - Name
 - Type
 - Description
 - Active status
 - Number and type of engines

## Tech Stack
- **Language**: Swift
- **Frameworks**: SwiftUI, Swift Concurrency, Observation, XCTest
- **API Handling**: URLSession with async-await

## FAQ

**Can I build my UI in either UIKit or SwiftUI?**
SwiftUI is our preferred framework. However, if you have more experience with UIKit, a well-structured UIKit implementation, paired with a strong willingness to learn SwiftUI, is also welcome.

**I have some questions regarding the problem statement.**
For any unspecified requirements, use your best judgment to determine the expected results.

**How long do I have to complete the exercise?**
Please complete this exercise within **one week** if possible, but you may take additional time if needed.

**How do I submit my exercise?**
Please provide a **Git link** to a **public repository** containing your code.

**How will this exercise be evaluated?**
An engineer will review your submission. At a minimum, the app should produce the expected results. Ensure that any necessary documentation is included in the repository.
Make the app as complete as you want. The goal is to show how familiar you are with these concepts, not to build a complete app.
While your solution doesn't need to be production-ready, it will be assessed, so put your best foot forward.

# SpaceX API Documentation for iOS App

This document outlines all the API endpoints and models required for implementing the SpaceX Info iOS app.

## Base URL

```
https://api.spacexdata.com
```

## API Versions

- Launches API: v5
- Rockets API: v4

## Network Models

```swift
public struct Launch: Identifiable, Decodable {
    public let id: String
    public let name: String
    public let flightNumber: Int
    public let dateUtc: Date
    public let dateUnix: Int
    public let dateLocal: Date
    public let datePrecision: DatePrecision
    public let upcoming: Bool
    public let success: Bool?
    public let details: String?
    public let rocket: String
    public let launchpad: String
    public let links: LaunchLinks
    public let cores: [LaunchCore]
    
    public init(id: String, 
                name: String, 
                flightNumber: Int, 
                dateUtc: Date, 
                dateUnix: Int, 
                dateLocal: Date, 
                datePrecision: DatePrecision, 
                upcoming: Bool, 
                success: Bool?, 
                details: String?, 
                rocket: String, 
                launchpad: String, 
                links: LaunchLinks, 
                cores: [LaunchCore]) {
        self.id = id
        self.name = name
        self.flightNumber = flightNumber
        self.dateUtc = dateUtc
        self.dateUnix = dateUnix
        self.dateLocal = dateLocal
        self.datePrecision = datePrecision
        self.upcoming = upcoming
        self.success = success
        self.details = details
        self.rocket = rocket
        self.launchpad = launchpad
        self.links = links
        self.cores = cores
    }
}

public enum DatePrecision: String, Decodable {
    case hour, day, month, quarter, year, half
}

public struct LaunchLinks: Decodable {
    public let patch: PatchLinks?
    public let webcast: URL?
    public let article: URL?
    public let wikipedia: URL?
    public let flickr: FlickrLinks
    
    public init(patch: PatchLinks?, 
                webcast: URL?, 
                article: URL?, 
                wikipedia: URL?, 
                flickr: FlickrLinks) {
        self.patch = patch
        self.webcast = webcast
        self.article = article
        self.wikipedia = wikipedia
        self.flickr = flickr
    }
}

public struct PatchLinks: Decodable {
    public let small: URL?
    public let large: URL?
    
    public init(small: URL?, large: URL?) {
        self.small = small
        self.large = large
    }
}

public struct FlickrLinks: Decodable {
    public let small: [URL]
    public let original: [URL]
    
    public init(small: [URL], original: [URL]) {
        self.small = small
        self.original = original
    }
}

public struct LaunchCore: Decodable {
    public let core: String?
    public let flight: Int?
    public let reused: Bool?
    public let landingSuccess: Bool?
    public let landingType: LandingType?
    
    public init(core: String?, 
                flight: Int?, 
                reused: Bool?, 
                landingSuccess: Bool?, 
                landingType: LandingType?) {
        self.core = core
        self.flight = flight
        self.reused = reused
        self.landingSuccess = landingSuccess
        self.landingType = landingType
    }
}

public enum LandingType: String, Decodable {
    case asds = "ASDS" // Autonomous Spaceport Drone Ship
    case rtls = "RTLS" // Return To Launch Site
    case ocean
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
    
    public init(docs: [Launch], 
                totalDocs: Int, 
                limit: Int, 
                totalPages: Int, 
                page: Int, 
                pagingCounter: Int, 
                hasPrevPage: Bool, 
                hasNextPage: Bool, 
                prevPage: Int?, 
                nextPage: Int?) {
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

// MARK: - Launchpad
public struct Launchpad: Identifiable, Decodable {
    public let id: String
    public let name: String
    public let fullName: String
    public let locality: String
    public let region: String
    public let timezone: String
    public let latitude: Double
    public let longitude: Double
    public let launchAttempts: Int
    public let launchSuccesses: Int
    public let rockets: [String]
    public let launches: [String]
    public let status: String
    
    public init(id: String,
                name: String,
                fullName: String,
                locality: String,
                region: String,
                timezone: String,
                latitude: Double,
                longitude: Double,
                launchAttempts: Int,
                launchSuccesses: Int,
                rockets: [String],
                launches: [String],
                status: String) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.locality = locality
        self.region = region
        self.timezone = timezone
        self.latitude = latitude
        self.longitude = longitude
        self.launchAttempts = launchAttempts
        self.launchSuccesses = launchSuccesses
        self.rockets = rockets
        self.launches = launches
        self.status = status
    }
}

// MARK: - Rocket Models
public struct Rocket: Identifiable, Decodable {
    public let id: String
    public let name: String
    public let type: String
    public let active: Bool
    public let stages: Int
    public let boosters: Int
    public let costPerLaunch: Int
    public let successRatePct: Int
    public let firstFlight: Date
    public let country: String
    public let company: String
    public let height: Dimension
    public let diameter: Dimension
    public let mass: Mass
    public let payloadWeights: [PayloadWeight]
    public let firstStage: Stage
    public let secondStage: Stage
    public let engines: EngineInfo
    public let landingLegs: LandingLegs
    public let flickrImages: [URL]
    public let wikipedia: URL?
    public let description: String
    
    public init(id: String, 
                name: String, 
                type: String, 
                active: Bool, 
                stages: Int, 
                boosters: Int, 
                costPerLaunch: Int, 
                successRatePct: Int, 
                firstFlight: Date, 
                country: String, 
                company: String, 
                height: Dimension, 
                diameter: Dimension, 
                mass: Mass, 
                payloadWeights: [PayloadWeight], 
                firstStage: Stage, 
                secondStage: Stage, 
                engines: EngineInfo, 
                landingLegs: LandingLegs, 
                flickrImages: [URL], 
                wikipedia: URL?, 
                description: String) {
        self.id = id
        self.name = name
        self.type = type
        self.active = active
        self.stages = stages
        self.boosters = boosters
        self.costPerLaunch = costPerLaunch
        self.successRatePct = successRatePct
        self.firstFlight = firstFlight
        self.country = country
        self.company = company
        self.height = height
        self.diameter = diameter
        self.mass = mass
        self.payloadWeights = payloadWeights
        self.firstStage = firstStage
        self.secondStage = secondStage
        self.engines = engines
        self.landingLegs = landingLegs
        self.flickrImages = flickrImages
        self.wikipedia = wikipedia
        self.description = description
    }
}

public struct Dimension: Decodable {
    public let meters: Double?
    public let feet: Double?
    
    public init(meters: Double?, feet: Double?) {
        self.meters = meters
        self.feet = feet
    }
}

public struct Mass: Decodable {
    public let kg: Int
    public let lb: Int
    
    public init(kg: Int, lb: Int) {
        self.kg = kg
        self.lb = lb
    }
}

public struct PayloadWeight: Decodable, Identifiable {
    public let id: String
    public let name: String
    public let kg: Int
    public let lb: Int
    
    public init(id: String, name: String, kg: Int, lb: Int) {
        self.id = id
        self.name = name
        self.kg = kg
        self.lb = lb
    }
}

public struct Stage: Decodable {
    public let reusable: Bool
    public let engines: Int?
    public let fuelAmountTons: Double?
    public let burnTimeSec: Int?
    
    public init(reusable: Bool, engines: Int?, fuelAmountTons: Double?, burnTimeSec: Int?) {
        self.reusable = reusable
        self.engines = engines
        self.fuelAmountTons = fuelAmountTons
        self.burnTimeSec = burnTimeSec
    }
}

public struct EngineInfo: Decodable {
    public let number: Int
    public let type: String
    public let version: String?
    public let layout: String?
    public let propellant1: String
    public let propellant2: String
    
    public init(number: Int, 
                type: String, 
                version: String?, 
                layout: String?, 
                propellant1: String, 
                propellant2: String) {
        self.number = number
        self.type = type
        self.version = version
        self.layout = layout
        self.propellant1 = propellant1
        self.propellant2 = propellant2
    }
}

public struct LandingLegs: Decodable {
    public let number: Int
    public let material: String?
    
    public init(number: Int, material: String?) {
        self.number = number
        self.material = material
    }
}

public struct RocketsResponse: Decodable {
    public let docs: [Rocket]
    public let totalDocs: Int
    public let limit: Int
    public let totalPages: Int
    public let page: Int
    public let pagingCounter: Int
    public let hasPrevPage: Bool
    public let hasNextPage: Bool
    public let prevPage: Int?
    public let nextPage: Int?
    
    public init(docs: [Rocket], 
                totalDocs: Int, 
                limit: Int, 
                totalPages: Int, 
                page: Int, 
                pagingCounter: Int, 
                hasPrevPage: Bool, 
                hasNextPage: Bool, 
                prevPage: Int?, 
                nextPage: Int?) {
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

public struct Launchpad: Identifiable, Decodable {
    public let id: String
    public let name: String
    public let fullName: String
    public let locality: String
    public let region: String
    public let timezone: String
    public let latitude: Double
    public let longitude: Double
    public let launchAttempts: Int
    public let launchSuccesses: Int
    public let rockets: [String]
    public let launches: [String]
    public let status: String
    
    public init(id: String,
                name: String,
                fullName: String,
                locality: String,
                region: String,
                timezone: String,
                latitude: Double,
                longitude: Double,
                launchAttempts: Int,
                launchSuccesses: Int,
                rockets: [String],
                launches: [String],
                status: String) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.locality = locality
        self.region = region
        self.timezone = timezone
        self.latitude = latitude
        self.longitude = longitude
        self.launchAttempts = launchAttempts
        self.launchSuccesses = launchSuccesses
        self.rockets = rockets
        self.launches = launches
        self.status = status
    }
}

// MARK: - Request Models

struct LaunchesQueryRequest {
    let query: [String: Any]
    let options: [String: Any]
    
    static func createDefault(page: Int = 1, limit: Int = 10) -> LaunchesQueryRequest {
        return LaunchesQueryRequest(
            query: [:],
            options: [
                "page": page,
                "limit": limit,
                "sort": ["date_utc": "desc"]
            ]
        )
    }
    
    static func createWithDateFilter(startDate: Date, endDate: Date, page: Int = 1, limit: Int = 10) -> LaunchesQueryRequest {
        let formatter = ISO8601DateFormatter()
        
        return LaunchesQueryRequest(
            query: [
                "date_utc": [
                    "$gte": formatter.string(from: startDate),
                    "$lte": formatter.string(from: endDate)
                ]
            ],
            options: [
                "page": page,
                "limit": limit,
                "sort": ["date_utc": "desc"]
            ]
        )
    }
}

struct RocketsQueryRequest {
    let query: [String: Any]
    let options: [String: Any]
    
    static func createDefault(page: Int = 1, limit: Int = 10) -> RocketsQueryRequest {
        return RocketsQueryRequest(
            query: [:],
            options: [
                "page": page,
                "limit": limit,
                "sort": ["name": "asc"]
            ]
        )
    }
}

// MARK: - Network Service
public protocol APIService {
    func fetchItems<T: Decodable>(endpoint: String, page: Int, limit: Int) async throws -> PaginatedResponse<T>
    func fetchItem<T: Decodable>(endpoint: String, id: String) async throws -> T
}

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

    public func fetchItems<T: Decodable>(endpoint: String, page: Int, limit: Int) async throws -> PaginatedResponse<T> {
        // Create request body with pagination
        let requestBody: [String: Any] = [
            "query": [:],
            "options": [
                "page": page,
                "limit": limit,
                "sort": endpoint == "launches" ? ["date_utc": "desc"] : ["name": "asc"]
            ]
        ]

        // Determine API version based on endpoint
        let apiVersion = endpoint == "launches" ? "v5" : "v4"
        let url = URL(string: "\(baseURL)/\(apiVersion)/\(endpoint)/query")!

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

    public func fetchItem<T: Decodable>(endpoint: String, id: String) async throws -> T {
        // Determine API version based on endpoint
        let apiVersion = endpoint == "launches" ? "v5" : "v4"
        let url = URL(string: "\(baseURL)/\(apiVersion)/\(endpoint)/\(id)")!

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
```

## API Endpoints

### Launches Endpoints

#### Get Launches List (Paginated)

- **Method**: POST
- **URL**: `https://api.spacexdata.com/v5/launches/query`
- **Body**:
```json
{
  "query": {},
  "options": {
    "page": 1,
    "limit": 10,
    "sort": {
      "date_utc": "desc"
    }
  }
}
```
- **Response**: `LaunchesResponse` containing a paginated list of `Launch` objects

#### Get Launches with Date Filter

- **Method**: POST
- **URL**: `https://api.spacexdata.com/v5/launches/query`
- **Body**:
```json
{
  "query": {
    "date_utc": {
      "$gte": "2020-01-01T00:00:00.000Z",
      "$lte": "2020-12-31T23:59:59.000Z"
    }
  },
  "options": {
    "page": 1,
    "limit": 10,
    "sort": {
      "date_utc": "desc"
    }
  }
}
```
- **Response**: `LaunchesResponse` containing a filtered, paginated list of `Launch` objects

#### Get Launch Detail

- **Method**: GET
- **URL**: `https://api.spacexdata.com/v5/launches/{id}`
- **Response**: Single `Launch` object

### Launchpad Endpoint

#### Get Launchpad Detail

- **Method**: GET
- **URL**: `https://api.spacexdata.com/v4/launchpads/{id}`
- **Response**: Single `Launchpad` object

### Rockets Endpoints

#### Get Rockets List (Paginated)

- **Method**: POST
- **URL**: `https://api.spacexdata.com/v4/rockets/query`
- **Body**:
```json
{
  "query": {},
  "options": {
    "page": 1,
    "limit": 10,
    "sort": {
      "name": "asc"
    }
  }
}
```
- **Response**: `RocketsResponse` containing a paginated list of `Rocket` objects

#### Get Rocket Detail

- **Method**: GET
- **URL**: `https://api.spacexdata.com/v4/rockets/{id}`
- **Response**: Single `Rocket` object

# SpaceX App Architecture

## Model Layer

### Data Models
- Use proper types (URL for URLs, Date for dates)
- Use enums for string-backed types where applicable (DatePrecision, LandingType)
- Configure JSONDecoder to handle snake_case conversion automatically
- Properly handle non-conforming values and special formats

### State Management


## Caching Strategy

### Multi-Level Cache
- Use URLCache for HTTP response caching
- Implement "stale-while-revalidate" pattern:
  1. Try to get cached data first (fast)
  2. Show immediately if available
  3. Fetch fresh data in parallel
  4. Update UI when fresh data arrives

### Repository Pattern
# Generic Views and Repositories Pattern

## Generic State Management

```swift
// Represents the loading state of any model
enum LoadState<T> {
    case initial
    case loading
    case refreshing(current: T)
    case loaded(data: T, isFresh: Bool)
    case error(Error)
    
    var currentData: T? {
        switch self {
        case .loaded(let data, _):
            return data
        case .refreshing(let current):
            return current
        default:
            return nil
        }
    }
    
    var isLoading: Bool {
        switch self {
        case .loading, .refreshing:
            return true
        default:
            return false
        }
    }
}
```

## Generic Repository Protocol

```swift
protocol Repository<T> {
    associatedtype T: Identifiable
    
    // State
    var state: LoadState<[T]> { get }
    
    // Core operations
    func load() async
    func refresh() async
    func loadMore(after item: T) async
    
    // Single item operations
    func getItem(id: T.ID) async -> LoadState<T>
    func refreshItem(id: T.ID) async -> LoadState<T>
}

// Define the APIService protocol
protocol APIService {
    func fetchItems<T: Decodable>(endpoint: String, page: Int) async throws -> PaginatedResponse<T>
    func fetchItem<T: Decodable>(endpoint: String, id: String) async throws -> T
}

// Define pagination response structure
struct PaginatedResponse<T: Decodable> {
    let items: [T]
    let page: Int
    let totalPages: Int
    let hasNextPage: Bool
}
```

## Generic UI Components

### LoadStateView

A generic view that handles all loading states:

```swift
import SwiftUI
import RepositoryDefinitions

public struct LoadStateView<T, Content: View>: View {
    private let state: LoadState<T>
    private let content: (T) -> Content
    private let retry: () async -> Void

    public init(
        state: LoadState<T>,
        @ViewBuilder content: @escaping (T) -> Content,
        retry: @escaping () async -> Void
    ) {
        self.state = state
        self.content = content
        self.retry = retry
    }

    public var body: some View {
        Group {
            switch state {
            case .initial, .loading:
                ProgressView()

            case .refreshing(let data), .loaded(let data, _):
                ZStack {
                    content(data)

                    if case .refreshing = state {
                        ProgressView()
                    }
                }

            case .error(let error):
                VStack(spacing: 16) {
                    Text("Error loading data")
                        .font(.headline)
                    Text(error.localizedDescription)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                    Button("Retry") {
                        Task { await retry() }
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}
```

### PaginatedListView

A generic list view with automatic pagination:

```swift
import SwiftUI
import RepositoryDefinitions

public struct PaginatedListView<T: Identifiable, RowContent: View>: View {
    private let items: [T]
    private let rowContent: (T) -> RowContent
    private let isLoading: Bool
    private let loadMore: (T) async -> Void
    private let refresh: () async -> Void

    public init(
        items: [T],
        isLoading: Bool,
        @ViewBuilder rowContent: @escaping (T) -> RowContent,
        loadMore: @escaping (T) async -> Void,
        refresh: @escaping () async -> Void
    ) {
        self.items = items
        self.rowContent = rowContent
        self.isLoading = isLoading
        self.loadMore = loadMore
        self.refresh = refresh
    }

    public var body: some View {
        List {
            ForEach(items) { item in
                rowContent(item)
                    .task {
                        await loadMore(item)
                    }
            }

            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .refreshable {
            await refresh()
        }
    }
}
```

## Usage Example

```swift
struct RocketsListView: View {
    @State private var repository: any Repository
    
    init(repository: some Repository<Rocket>) {
        self.repository = repository
    }
    
    var body: some View {
        LoadStateView(
            state: repository.state,
            content: { rockets in
                PaginatedListView(
                    items: rockets,
                    rowContent: { rocket in
                        NavigationLink(destination: RocketDetailView(rocketId: rocket.id)) {
                            RocketRowView(rocket: rocket)
                        }
                    },
                    isLoading: repository.state.isLoading,
                    loadMore: { rocket in
                        await repository.loadMore(after: rocket)
                    },
                    refresh: {
                        await repository.refresh()
                    }
                )
            },
            retry: {
                await repository.load()
            }
        )
        .task {
            await repository.load()
        }
    }
}

struct RocketDetailView: View {
    let rocketId: String
    @State private var repository: any Repository
    @State private var rocketState: LoadState<Rocket> = .initial
    
    init(rocketId: String, repository: some Repository<Rocket>) {
        self.rocketId = rocketId
        self.repository = repository
    }
    
    var body: some View {
        LoadStateView(
            state: rocketState,
            content: { rocket in
                RocketDetailContent(rocket: rocket)
            },
            retry: {
                await loadRocket()
            }
        )
        .task {
            await loadRocket()
        }
    }
    
    private func loadRocket() async {
        rocketState = await repository.getItem(id: rocketId)
    }
}
```
```swift
public struct ErrorView: View {
    private let title: String
    private let message: String
    private let retryAction: () async -> Void

    public init(
        title: String = "Error",
        message: String,
        retryAction: @escaping () async -> Void
    ) {
        self.title = title
        self.message = message
        self.retryAction = retryAction
    }

    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundStyle(.red)

            Text(title)
                .font(.headline)

            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            Button("Try Again") {
                Task {
                    await retryAction()
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}
```

This architecture delivers:
- Type-safe repositories through Swift generics
- Consistent state handling for all data
- Reusable UI components for loading states
- Automatic pagination
- Background refreshing
- Multi-level caching

### Implementation Approach
We're checking first if there's a cached result. If so, we return that result, and then kick off another network request that will fetch a fresh instance.




## Feature Implementation

That's a solid approach. Essentially you're implementing a stale-while-revalidate pattern:

1. First try to get the cached data (fast)
1. Show it immediately if available
1. In parallel, fetch fresh data from network
1. Update UI when fresh data arrives

```swift
extension HTTPURLResponse {
    var isResponseFromCache: Bool {
        allHeaderFields["X-Cache"] as? String == "HIT"
        // Or check other cache indicators, depending on your setup
    }
}
```

## Implementation Notes

1. **Pagination**: Both launches and rockets lists support pagination with page number and limit.

2. **Date Filtering**: Launches can be filtered by date range using the MongoDB query format with `$gte` and `$lte` operators.

3. **Error Handling**: The API returns HTTP 404 for non-existent resources. Implement proper error handling in your app.

4. **Image Handling**: Both launches and rockets provide image URLs that should be loaded asynchronously.

5. **Rocket Reference**: Launch objects contain a rocket ID that needs to be used to fetch the associated rocket details.

6. **Authentication**: None of these endpoints require authentication.

7. **Rate Limiting**: Be conscious of API rate limits and implement caching where appropriate.

8. **Date Formatting**: Pay attention to date formats in the API - they use ISO 8601 strings.

## Packages
The app is structured in Modules that are structured in Packages. It's a well-organized modular approach that leverages Swift Packages for proper separation of concerns.
The architecture you're describing has:

* Clear separation between definitions and implementations
* Dedicated packages for UI components
* Mockable interfaces for testing
* Reusable components in SharedUI
* Preview targets that use mocks

This approach will make the codebase more maintainable, testable, and scalable. It also enables parallel development across different modules while maintaining well-defined interfaces.

* Modules/
  * Repository/
    * Definitions/ (Package)
      * Definitions target - protocols for repositories and network
    * Implementations/ (Package)
      * Generic repository and network handler
  * SharedUI/ (Package)
    * Reusable UI components, imports Definitions
  * Rockets/
    * UI/ (Package)
      * Views for rockets
      * Preview examples
    * Implementations/ (Package)
      * Concrete rocket repository implementation
    * Mocks/ (Package)
      * Mock rocket data and repositories for testing/previews
  * Launches/
    * UI/ (Package)
      * Views for launches
      * Preview examples 
    * Implementations/ (Package)
      * Concrete launch repository implementation
    * Mocks/ (Package)
      * Mock launch data and repositories for testing/previews

This way, each domain module has its own mocks that are specific to its domain needs, which is better for building focused previews.

All protocols, data definitions and Views that are shared between modules should be public.

## Mocks, Spies and Stubs
### Protocols
Mocks should implement the whole protocol, and make every variable accessible to read and write. Every function call should be counted, the arguments passed by every call stored in an array and an optional pre-set response should be returned. Mocks can crash when not set up correctly for the test at hand because they will never end up being used in production code.
### Data Types
Should be able to give individual edge cases for all fields, and also two arrays of different but static items to simulate paginating.

## Base Views
The following three Base Views have been defined:
```swift





```