//
//  LaunchDetailView.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 4/30/21.
//

import CoreLocation
import Kingfisher
import SwiftUI

struct LaunchDetailView: View {

    @ObservedObject var viewModel: LaunchDetailViewModel
    @Environment(\.presentationMode) var presentationMode

    init(viewModel: LaunchDetailViewModel) {
        self.viewModel = viewModel

        UIScrollView.appearance().backgroundColor = UIColor.systemBackground
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            // MARK: - Header imageview
            if viewModel.showHeaderImage {
                GeometryReader { reader in
                    if reader.frame(in: .global).minY > -300 {
                        KFImage(viewModel.galleryItem)
                            .resizable()
                            .placeholder({
                                ProgressView()
                            })
                            .loadImmediately()
                            .fade(duration: 0.25)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(y: -reader.frame(in: .global).minY)
                            .frame(width: UIScreen.main.bounds.width, height: reader.frame(in: .global).minY + 300)
                    }
                }
                .frame(height: 300)
            }

            // MARK: - Detail body
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 16) {
                    KFImage.url(viewModel.logoURL)
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

                    // MARK: - Title and logo View
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.launchTilte)
                            .fontWeight(.bold)
                            .font(.title2)
                        HStack {
                            Image(systemName: "calendar.badge.clock")
                            Text(viewModel.launchData)
                        }
                        if let status = viewModel.launchStatus {
                            HStack {
                                Image(systemName: status ? "checkmark.circle.fill" : "multiply.circle.fill")
                                    .foregroundColor(status ? .green : .red)
                                Text(status ? "Success" : "Failed")
                                    .fontWeight(.semibold)
                                    .foregroundColor(status ? .green : .red)
                                    .font(.headline)
                            }
                        } else {
                            HStack {
                                Image(systemName: "questionmark.circle.fill")
                                    .foregroundColor(.gray)
                                Text("Pending")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                    .font(.headline)
                            }
                        }
                    }
                    Spacer()
                }

                // MARK: - Rokcet Detail view
                VStack(alignment: .leading) {
                    HStack {
                        Rectangle()
                            .frame(width: 4)
                            .foregroundColor(Color.purple)
                        Text("Rocket Detail")
                            .font(.title3)
                            .fontWeight(.bold)
                        Button(action: {}) {
                            Image(systemName: "link")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundColor(.primary)
                        }
                        Spacer()
                        if viewModel.rocketInfo?.active ?? false {
                            Text("Active")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.green)
                        }
                    }
                    HStack {
                        Rectangle()
                            .frame(width: 4)
                            .foregroundColor(Color.clear)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Name: ")
                                .foregroundColor(.secondary)
                                .font(.callout)
                                + Text(viewModel.rocketInfo?.name ?? "-")
                                .font(.body)
                                .fontWeight(.semibold)
                            Text("Type: ")
                                .foregroundColor(.secondary)
                                .font(.callout)
                                + Text(viewModel.rocketInfo?.type ?? "-")
                                .font(.body)
                                .fontWeight(.semibold)
                            Text("Success rate: ")
                                .foregroundColor(.secondary)
                                .font(.callout)
                                + Text(viewModel.rocketInfo?.successRatePct != nil ? "% \(viewModel.rocketInfo?.successRatePct ?? 0)" : "Unknown")
                                .font(.body)
                                .fontWeight(.semibold)
                            Text("Company: ")
                                .foregroundColor(.secondary)
                                .font(.callout)
                                + Text(viewModel.rocketInfo?.company ?? "-")
                                .font(.body)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)

                // MARK: Launch and Landing views
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Rectangle()
                                .frame(width: 4)
                                .foregroundColor(Color.purple)
                            Text("Launch")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        HStack {
                            Rectangle()
                                .frame(width: 4)
                                .foregroundColor(Color.clear)
                            VStack(alignment: .leading, spacing: 8) {
                                Text(viewModel.launchpadInfo?.name ?? "-")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                Text(viewModel.launchpadInfo?.region ?? "-")
                                    .font(.caption)
                                    .fontWeight(.medium)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)

                    VStack(alignment: .leading) {
                        HStack {
                            Rectangle()
                                .frame(width: 4)
                                .foregroundColor(Color.purple)
                            Text("Landing")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        HStack {
                            Rectangle()
                                .frame(width: 4)
                                .foregroundColor(Color.clear)
                            VStack(alignment: .leading, spacing: 8) {
                                Text(viewModel.landpadInfo?.name ?? "-")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                Text(viewModel.landpadInfo?.region ?? "-")
                                    .font(.caption)
                                    .fontWeight(.medium)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }

                // MARK: - Mission Detail view
                VStack(alignment: .leading) {
                    HStack {
                        Rectangle()
                            .frame(width: 4)
                            .foregroundColor(Color.purple)
                        Text("Mission Details")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    Text(viewModel.launchDetails)
                        .font(.callout)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, viewModel.showHeaderImage ? 25 : 80)
            .padding(.horizontal)
            .background(Color(.systemBackground))
            .cornerRadius(25)
            .offset(y: viewModel.showHeaderImage ? -35 : 0 )
        }
        .overlay(
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 25, weight: .medium, design: .rounded))
                        .foregroundColor(.primary)
                        .background(Color(.systemBackground))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal)
            .padding(.top, 50),
            alignment: .top
        )
        .edgesIgnoringSafeArea(.all)
        .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
    }
}
