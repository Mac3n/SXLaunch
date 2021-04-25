//
//  LaunchListView.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 4/26/21.
//

import SwiftUI

struct LaunchListView: View {
    @StateObject var viewModel = LaunchListViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                Picker("", selection: $viewModel.selectedSection) {
                    Text("Latest").tag(LaunchListViewModel.SelectedSection.latest)
                    Text("Upcoming").tag(LaunchListViewModel.SelectedSection.upcoming)
                    Text("All").tag(LaunchListViewModel.SelectedSection.all)
                }
                .padding(.horizontal)
                .pickerStyle(SegmentedPickerStyle())
                LazyVStack {
                    ForEach(viewModel.docs) { doc in
                        LaunchItemView(doc: doc)
                            .onAppear {
                                viewModel.loadNextPage(currentItem: doc)
                            }
                    }
                }
            }
            .navigationTitle(Text("Launches"))
            .navigationBarTitleDisplayMode(.automatic)
            .onReceive(viewModel.$docs, perform: { docs in
                print(docs.count)
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LaunchListView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchListView()
    }
}

private struct LaunchItemView: View {
    var doc: Doc
    var body: some View {
        Text(doc.name ?? "")
            .frame(maxWidth: .infinity)
            .padding()

    }
}
