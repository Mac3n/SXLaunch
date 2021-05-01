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
    @Namespace var animation

    init() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor.secondarySystemBackground
        UIScrollView.appearance().backgroundColor = UIColor.secondarySystemBackground
    }

    var body: some View {
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
                                    .redacted(reason: viewModel.isLoading ? .placeholder : [])
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LaunchListView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchListView()
    }
}

private struct LaunchItemView: View {
    @State private var showDetail = false

    var doc: Doc
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Flight #\(doc.flightNumber ?? 0)")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                Spacer()
                HStack {
                    Image(systemName: "calendar.badge.clock")
                    Text((doc.dateUnix ?? 0).formattedDate())
                }
            }
            .padding(.horizontal)
            .padding(.top)
            HStack(spacing: 16) {
                KFImage.url(URL(string: (doc.links?.patch?.small) ?? ""))
                    .placeholder({
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                            ProgressView()
                        }
                    })
                    .fade(duration: 0.25)
                    .resizable()
                    .frame(width: 80, height: 80)
                VStack(alignment: .leading, spacing: 16) {
                    Text(doc.name ?? "")
                        .fontWeight(.bold)
                        .font(.title2)

                    if let status = doc.success {
                        HStack {
                            Image(systemName: status ? "checkmark.circle.fill" : "multiply.circle.fill")
                                .foregroundColor(status ? .green : .red)
                            Text(status ? "Success" : "Failed")
                                .fontWeight(.semibold)
                                .foregroundColor(status ? .green : .red)
                                .font(.headline)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(status ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                        .cornerRadius(8, corners: [.topLeft, .bottomRight])
                    } else {
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundColor(.gray)
                            Text("Pending")
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8, corners: [.topLeft, .bottomRight])
                    }
                }
            }
            .padding()
            if doc.hasDetail {
                HStack(alignment: .top) {
                    Image(systemName: "info.circle.fill")
                    Text(doc.prepareDetail)
                        .font(.subheadline)
                        + Text(" more...")
                        .foregroundColor(.accentColor)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .padding()
        .fullScreenCover(isPresented: $showDetail) {
            LaunchDetailView(viewModel: LaunchDetailViewModel(doc: doc))
        }
        .onTapGesture {
            showDetail.toggle()
        }
    }
}
