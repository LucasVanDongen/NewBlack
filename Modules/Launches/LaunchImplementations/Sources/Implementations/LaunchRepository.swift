//
//  LaunchRepository.swift
//  LaunchImplementations
//
//  Created by Lucas van Dongen on 26/03/2025.
//


import Foundation
import LaunchDefinitions
import RepositoryDefinitions

extension Endpoint {
    static let launches = Endpoint(path: "launches", version: .v5, sort: ["name": "asc"])
}

@Observable
public final class LaunchRepository: @unchecked Sendable, Repository, LaunchRepositoryImplementing {
    public typealias T = Launch
    
    // MARK: - Properties
    private(set) public var state: LoadState<[Launch]> = .initial
    private let service: LaunchAPIService
    private var currentPage = 1
    private let itemsPerPage = 25
    private var startDate: Date?
    private var endDate: Date?
    
    // MARK: - Initialization
    
    public init(service: LaunchAPIService) {
        self.service = service
    }
    
    // MARK: - Repository Implementation
    
    public func load() async {
        if case .loading = state { return }
        
        state = .loading
        do {
            let response = try await fetchLaunches(page: 1)
            state = .loaded(data: response.items, isFresh: true)
            currentPage = 1
        } catch {
            state = .error(error)
        }
    }
    
    public func refresh() async {
        if case .refreshing = state { return }
        
        if let currentData = state.currentData {
            state = .refreshing(current: currentData)
        } else {
            state = .loading
        }
        
        do {
            let response = try await fetchLaunches(page: 1)
            state = .loaded(data: response.items, isFresh: true)
            currentPage = 1
        } catch {
            if let currentData = state.currentData {
                state = .loaded(data: currentData, isFresh: false)
            } else {
                state = .error(error)
            }
        }
    }
    
    public func loadMore(after item: Launch) async {
        // Only load more if we're at the end of the current list
        guard let currentData = state.currentData,
              currentData.last?.id == item.id,
              !state.isLoading else {
            return
        }
        
        state = .refreshing(current: currentData)
        
        do {
            let nextPage = currentPage + 1
            let response = try await fetchLaunches(page: nextPage)
            
            // If no more results, just return current data
            if response.docs.isEmpty {
                state = .loaded(data: currentData, isFresh: true)
                return
            }
            
            // Combine existing and new data
            let combinedData = currentData + response.docs
            state = .loaded(data: combinedData, isFresh: true)
            currentPage = nextPage
        } catch {
            // On error, preserve current data
            state = .loaded(data: currentData, isFresh: false)
        }
    }
    
    public func getItem(id: String) async -> LoadState<Launch> {
        // First check if we already have this item in our current data
        if let currentData = state.currentData,
           let existingItem = currentData.first(where: { $0.id == id }) {
            let loadState: LoadState<Launch> = .loaded(data: existingItem, isFresh: true)

            // FIXME: I had to give up here because of time constraints.
            // What probably would have worked was returning an `AsyncStream` that would return first cached,
            // then the fresh data to the caller of this function (which would be something like `subscribe(to id: String)`
            //
            // Also try to refresh in the background
            //            Task {
            //                do {
            //                    let freshItem: Launch = try await service.fetchLaunch(id: id)
            //                    state = .loaded(data: freshItem, isFresh: true)
            //                } catch {
            //                    // Silently fail and return cached data
            //                    state = loadState
            //                }
            //            }
            
            return loadState
        }
        
        // Otherwise fetch it directly
        do {
            let launch: Launch = try await service.fetchLaunch(id: id)
            return .loaded(data: launch, isFresh: true)
        } catch {
            return .error(error)
        }
    }
    
    public func refreshItem(id: String) async -> LoadState<Launch> {
        do {
            let launch: Launch = try await service.fetchLaunch(id: id)
            return .loaded(data: launch, isFresh: true)
        } catch {
            return .error(error)
        }
    }
    
    // MARK: - Date Filtering
    
    public func filterByDateRange(start: Date?, end: Date?) async {
        startDate = start
        endDate = end
        
        if case .loading = state { return }
        
        if let currentData = state.currentData {
            state = .refreshing(current: currentData)
        } else {
            state = .loading
        }
        
        do {
            let response: PaginatedResponse<Launch> = try await service.fetchLaunches(startDate: startDate, endDate: endDate, page: 1, limit: itemsPerPage)
            state = .loaded(data: response.items, isFresh: true)
            currentPage = 1
        } catch {
            if let currentData = state.currentData {
                state = .loaded(data: currentData, isFresh: false)
            } else {
                state = .error(error)
            }
        }
    }
    
    public func clearDateFilter() async {
        startDate = nil
        endDate = nil
        await refresh()
    }
    
    // MARK: - Private Methods
    
    private func fetchLaunches(page: Int) async throws -> PaginatedResponse<Launch> {
        return try await service.fetchLaunches(startDate: startDate, endDate: endDate, page: page, limit: itemsPerPage)
    }
}
