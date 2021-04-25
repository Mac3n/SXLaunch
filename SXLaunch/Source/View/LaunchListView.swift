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
            ZStack {
                Color.purple
                    .ignoresSafeArea()
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.docs) { doc in
                            LaunchItemView(doc: doc)
                                .onAppear {
                                    viewModel.loadNextPage(currentItem: doc)
                                }
                        }
                    }
                }
            }
            .navigationTitle("Launches")
            .onReceive(viewModel.$docs, perform: { docs in
                print(docs.count)
            })
        }
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
