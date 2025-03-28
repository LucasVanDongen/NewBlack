//
//  SpaceXRepository.swift
//  RepositoryImplementations
//
//  Created by Lucas van Dongen on 25/03/2025.
//


import Foundation
import RepositoryDefinitions
import Observation

@Observable
public final class SpaceXRepository<T: Decodable & Identifiable & Sendable>: @unchecked Sendable, Repository {
    public private(set) var state: LoadState<[T]> = .initial
    private var currentPage = 1
    private var hasMorePages = true
    
    private let apiService: APIService
    private let endpoint: Endpoint
    private let session: URLSession
    private let cachePolicy: CachePolicy
    
    public init(
        apiService: APIService,
        endpoint: Endpoint,
        session: URLSession = .shared,
        cachePolicy: CachePolicy = .refreshIfStale(staleAfter: 60 * 5)
    ) {
        self.apiService = apiService
        self.endpoint = endpoint
        self.session = session
        self.cachePolicy = cachePolicy
        
        // Configure URLCache if needed
        if session.configuration.urlCache == nil {
            let cache = URLCache(memoryCapacity: 10_000_000, diskCapacity: 50_000_000)
            session.configuration.urlCache = cache
        }
    }
    
    public func load() async {
        // Don't start another load if we're already loading
        if case .loading = state { return }
        
        // If we have current data, switch to refreshing
        if let currentData = state.currentData {
            state = .refreshing(current: currentData)
        } else {
            state = .loading
        }
        
        do {
            // Use the API service to fetch items
            let response: PaginatedResponse<T> = try await apiService.fetchItems(endpoint: endpoint, page: currentPage, limit: 20)

            hasMorePages = response.hasNextPage
            state = .loaded(data: response.items, isFresh: true)
            
            // If cache policy is to refresh if stale, start refresh in background
            if case .refreshIfStale = cachePolicy {
                Task { [weak self] in
                    await self?.refresh()
                }
            }
        } catch {
            state = .error(error)
        }
    }
    
    public func refresh() async {
        // If we have current data, switch to refreshing
        if let currentData = state.currentData {
            state = .refreshing(current: currentData)
        } else {
            state = .loading
        }
        
        do {
            // Use the API service to fetch fresh items
            let response: PaginatedResponse<T> = try await apiService.fetchItems(endpoint: endpoint, page: currentPage, limit: 20)

            hasMorePages = response.hasNextPage
            state = .loaded(data: response.items, isFresh: true)
        } catch {
            // If refresh fails but we have existing data, keep it
            if let currentData = state.currentData {
                state = .loaded(data: currentData, isFresh: false)
            } else {
                state = .error(error)
            }
        }
    }
    
    public func loadMore(after item: T) async {
        guard hasMorePages, !state.isLoading else { return }
        
        if let items = state.currentData,
           let itemIndex = items.firstIndex(where: { $0.id == item.id }),
           itemIndex >= items.count - 3 {
            currentPage += 1
            await loadNextPage()
        }
    }
    
    private func loadNextPage() async {
        // Keep current data while loading
        if let currentData = state.currentData {
            state = .refreshing(current: currentData)
        }
        
        do {
            let response: PaginatedResponse<T> = try await apiService.fetchItems(endpoint: endpoint, page: currentPage, limit: 20)
            hasMorePages = response.hasNextPage
            
            // Append new items to existing ones
            if var currentItems = state.currentData {
                currentItems.append(contentsOf: response.items)
                state = .loaded(data: currentItems, isFresh: true)
            } else {
                state = .loaded(data: response.items, isFresh: true)
            }
        } catch {
            // If loading more fails but we have existing data, keep it
            if let currentData = state.currentData {
                state = .loaded(data: currentData, isFresh: false)
            } else {
                state = .error(error)
            }
        }
    }
    
    public func getItem(id: T.ID) async -> LoadState<T> {
        // Try to find in current items first
        if let items = state.currentData,
           let item = items.first(where: { $0.id == id }) {
            // Capture just what you need for the background task
            let itemID: String = "\(id)"

            // Start refreshing in background
            Task { [weak self] in
                _ = await self?.refreshItem(id: itemID as! T.ID)
            }

            // Immediately return current item with refreshing state
            return .loaded(data: item, isFresh: false) // .refreshing(current: item)
        }
        
        // Not in current items, load fresh
        return await refreshItem(id: id)
    }

    public func refreshItem(id: T.ID) async -> LoadState<T> {
        do {
            // Convert id to string (required for API call)
            let idString = "\(id)"
            let item: T = try await apiService.fetchItem(endpoint: endpoint, id: idString)

            // Update in current items list if present
            if var items = state.currentData,
               let index = items.firstIndex(where: { $0.id == id }) {
                items[index] = item
                state = .loaded(data: items, isFresh: true)
            }
            
            return .loaded(data: item, isFresh: true)
        } catch {
            return .error(error)
        }
    }
}
