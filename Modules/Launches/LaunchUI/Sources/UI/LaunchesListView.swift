//
//  LaunchesListView.swift
//  LaunchUI
//
//  Created by Lucas van Dongen on 26/03/2025.
//

import SwiftUI
import LaunchDefinitions
import RepositoryDefinitions
import RocketDefinitions
import SharedUI

public struct LaunchesListView: View {
    @State private var repository: any Repository<Launch>
    @State private var startDate: Date?
    @State private var endDate: Date?
    @State private var showingStartDatePicker = false
    @State private var showingEndDatePicker = false

    private let rocketCardProvider: any RocketCardProviding
    private let launchpadRepository: any Repository<Launchpad>

    public init(
        rocketCardProvider: any RocketCardProviding,
        repository: some Repository<Launch>,
        launchpadRepository: some Repository<Launchpad>
    ) {
        self.rocketCardProvider = rocketCardProvider
        self._repository = State(initialValue: repository)
        self.launchpadRepository = launchpadRepository
    }
    
    public var body: some View {
        VStack {
            // Date filter controls
            dateFilterView
            
            // Launches list with loading state handling
            LoadStateView(
                state: repository.state,
                content: { launches in
                    PaginatedListView(
                        items: launches,
                        isLoading: repository.state.isLoading,
                        rowContent: { launch in
                            NavigationLink(
                                destination: LaunchDetailView(
                                    launchId: launch.id,
                                    rocketCardProvider: rocketCardProvider,
                                    repository: repository,
                                    launchpadRepository: launchpadRepository
                                )
                            ) {
                                LaunchRowView(launch: launch, launchpadRepository: launchpadRepository)
                            }
                        },
                        loadMore: { launch in
                            await repository.loadMore(after: launch)
                        },
                        refresh: {
                            await repository.refresh()
                        }
                    )
                },
                retry: {
                    await repository.load()
                }
            ).frame(maxHeight: .infinity)
        }
        .navigationTitle("Launches")
        .task {
            await repository.load()
        }
    }
    
    private var dateFilterView: some View {
        VStack(spacing: 12) {
            HStack {
                dateButton(
                    label: startDate == nil ? "Start Date" : DateFormatter.formatted(date: startDate!),
                    action: {
                        showingStartDatePicker.toggle()
                        if showingStartDatePicker {
                            showingEndDatePicker = false
                        }
                    },
                    clearAction: startDate == nil ? nil : {
                        startDate = nil
                        applyDateFilter()
                    }
                )

                dateButton(
                    label: endDate == nil ? "End Date" : DateFormatter.formatted(date: endDate!),
                    action: {
                        showingEndDatePicker.toggle()
                        if showingEndDatePicker {
                            showingStartDatePicker = false
                        }
                    },
                    clearAction: endDate == nil ? nil : {
                        endDate = nil
                        applyDateFilter()
                    }
                )
            }
            
            if showingStartDatePicker {
                datePicker(selection: $startDate, onDismiss: {
                    showingStartDatePicker = false
                    applyDateFilter()
                })
            }
            
            if showingEndDatePicker {
                datePicker(selection: $endDate, onDismiss: {
                    showingEndDatePicker = false
                    applyDateFilter()
                })
            }
        }
        .padding(.horizontal)
    }
    
    private func dateButton(label: String, action: @escaping () -> Void, clearAction: (() -> Void)?) -> some View {
        HStack {
            Button(action: action) {
                Text(label)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            
            if let clearAction = clearAction {
                Button(action: clearAction) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    private func datePicker(selection: Binding<Date?>, onDismiss: @escaping () -> Void) -> some View {
        VStack {
            DatePicker(
                "Select date",
                selection: Binding(
                    get: { selection.wrappedValue ?? Date() },
                    set: { selection.wrappedValue = $0 }
                ),
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .labelsHidden()
            
            Button("Done") {
                onDismiss()
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
    
    private func applyDateFilter() {
        Task {
            await (repository as? LaunchRepositoryImplementing)?.filterByDateRange(start: startDate, end: endDate)
        }
    }
}
