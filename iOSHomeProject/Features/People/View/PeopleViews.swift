//
//  PeopleViews.swift
//  iOSHomeProject
//
//  Created by Ricardo Garza on 5/16/24.
//

import SwiftUI

struct PeopleViews: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    @State private var shouldShowCreate = false
    @StateObject private var vm = PeopleViewModel()
    @State private var shouldShowSuccess: Bool = false
    @State private var hasAppeared = false
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                
                if vm.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16, content: {
                            ForEach(vm.users, id: \.id) { user in
                                NavigationLink {
                                    DetailView(userId: user.id)
                                } label: {
                                    PersonItemView(user: user)
                                        .task {
                                            if vm.hasReachedEnd(of: user) && !vm.isFetching {
                                                await vm.fetchNextSetOfUsers()
                                            }
                                        }
                                }
                            }
                        })
                        .padding()
                    }
                    .overlay(alignment: .bottom) {
                        if vm.isFetching {
                            ProgressView()
                        }
                    }
                }
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    create
                }
                ToolbarItem(placement: .topBarLeading) {
                    refresh
                }
            }
            .task {
                if !hasAppeared {
                    await vm.fetchUsers()
                    hasAppeared = true
                }
            }
            .sheet(isPresented: $shouldShowCreate, content: {
                CreateView {
                    haptic(.success)
                    withAnimation(.spring().delay(0.25)) {
                        self.shouldShowSuccess.toggle()
                    }
                }
            })
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    Task {
                       await vm.fetchUsers()
                    }
                }
            }
            .overlay {
                if shouldShowSuccess {
                    CheckmarkPopoverView()
                        .transition(.scale.combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.spring()) {
                                    self.shouldShowSuccess.toggle()
                                }
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    PeopleViews()
}

private extension PeopleViews {
    
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
    var create: some View {
        Button(action: {
            shouldShowCreate.toggle()
        }, label: {
            Symbols.plus
                .font(.system(.headline, design: .rounded).bold())
        })
        .disabled(vm.isLoading)
    }
    
    var refresh: some View {
        Button(action: {
            Task {
                await vm.fetchUsers()
            }
        }, label: {
            Symbols.refresh
                .font(.system(.headline, design: .rounded).bold())

        })
        .disabled(vm.isLoading)
    }
}
