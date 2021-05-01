//
//  ContentView.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 4/21/21.
//

import Kingfisher
import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var showAllLaunches = false

    var body: some View {
        NavigationView {
        ZStack {
            Image("launch_image")
                .resizable()
                .fixedSize(horizontal: true, vertical: false)
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 2)
                .overlay(Color.black.opacity(0.3).edgesIgnoringSafeArea(.all))
                .padding(-50)
            VStack {
                HStack {
                    Text("Next Launch")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
                .padding()
                VStack {
                    HStack {
                        KFImage.url(URL(string: (viewModel.doc?.links?.patch?.small) ?? ""))
                            .placeholder({
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color.gray.opacity(0.1))
                                        .cornerRadius(16)
                                    ProgressView()
                                }
                            })
                            .fade(duration: 0.25)
                            .resizable()
                            .frame(width: 80, height: 80)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(viewModel.doc?.name ?? "")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Text("Flight number: #\(viewModel.doc?.flightNumber ?? 0)")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        Spacer()
                    }
                    .padding()

                    HStack {
                        VStack {
                            Text("Days")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                            Text(viewModel.countDownDays)
                                .font(.title3)
                                .fontWeight(.heavy)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.white.opacity(0.3))
                                .cornerRadius(4)
                        }
                        .frame(maxWidth: .infinity)
                        VStack {
                            Text("Hours")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                            Text(viewModel.countDownHours)
                                .font(.title3)
                                .fontWeight(.heavy)
                                .frame(width: 30, height: 30)

                                .foregroundColor(.white)
                                .padding()
                                .background(Color.white.opacity(0.3))
                                .cornerRadius(4)
                        }
                        .frame(maxWidth: .infinity)
                        VStack {
                            Text("Minutes")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                            Text(viewModel.countDownMinutes)
                                .font(.title3)
                                .fontWeight(.heavy)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.white.opacity(0.3))
                                .cornerRadius(4)
                        }
                        .frame(maxWidth: .infinity)
                        VStack {
                            Text("Seconds")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                            Text(viewModel.countDownSeconds)
                                .font(.title3)
                                .fontWeight(.heavy)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.white.opacity(0.3))
                                .cornerRadius(4)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground).opacity(0.4))
                .cornerRadius(8)
                .padding()

                Button(action: {
                    showAllLaunches.toggle()
                }, label: {
                    HStack {
                        Image(systemName: "flame.fill")
                        Text("Show All Launches")
                            .fontWeight(.bold)
                    }
                    .font(.title3)
                    .foregroundColor(Color.white)
                })
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color(.systemBackground).opacity(0.4))
                .cornerRadius(8)
                .padding(.horizontal)

                NavigationLink(
                    destination: LaunchListView(),
                    isActive: $showAllLaunches,
                    label: {
                        EmptyView()
                    })
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("Home")
            .navigationBarHidden(true)
        }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
