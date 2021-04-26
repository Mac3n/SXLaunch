//
//  LaunchListView.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 4/26/21.
//

import Kingfisher
import SwiftUI

struct LaunchListView: View {
    @StateObject var viewModel = LaunchListViewModel()

    init() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor.secondarySystemBackground
        UIScrollView.appearance().backgroundColor = UIColor.secondarySystemBackground
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ScrollView {
                        LazyVStack(spacing: 8, pinnedViews: [.sectionHeaders]) {
                            Section(header: Picker("", selection: $viewModel.selectedSection) {
                                Text("Latest").tag(LaunchListViewModel.SelectedSection.latest)
                                Text("Upcoming").tag(LaunchListViewModel.SelectedSection.upcoming)
                                Text("All").tag(LaunchListViewModel.SelectedSection.all)
                            }
                            .background(Color(.secondarySystemBackground))
                            .padding()
                            .pickerStyle(SegmentedPickerStyle())) {
                                ForEach(viewModel.docs) { doc in
                                    LaunchItemView(doc: doc)
                                        .onAppear {
                                            viewModel.loadNextPage(currentItem: doc)
                                        }
                                }
                            }
                        }
                    }
                    if viewModel.isLoading {
                        ProgressView()
                    }
                }
            }
            .navigationTitle(Text("Launches"))
            .navigationBarTitleDisplayMode(.automatic)
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
        VStack(alignment: .leading) {
            VStack(spacing: 12) {
                HStack {
                    Text("Flight #\(doc.flightNumber ?? 0)")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    Spacer()
                    if let status = doc.success {
                        Text(status ? "Success" : "Failed")
                            .fontWeight(.semibold)
                            .foregroundColor(status ? .green : .red)
                            .font(.subheadline)
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            .background(status ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                            .cornerRadius(8, corners: [.topLeft, .bottomLeft])
                    }
                }
                .padding(.leading)
                .padding(.top)
                HStack {
                    KFImage.url(URL(string: (doc.links?.patch?.small) ?? ""))
                        .fade(duration: 0.25)
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack {
                        Text(doc.name ?? "")
                            .fontWeight(.bold)
                            .font(.title2)
                    }
                    Spacer()
                }
                .padding(.leading)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .padding()
    }
}
