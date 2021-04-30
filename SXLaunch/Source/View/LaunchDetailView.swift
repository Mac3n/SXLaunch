//
//  LaunchDetailView.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 4/30/21.
//

import Kingfisher
import SwiftUI

struct LaunchDetailView: View {

    @ObservedObject var viewModel: LaunchDetailViewModel
    @Environment(\.presentationMode) var presentationMode

    init(viewModel: LaunchDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            GeometryReader { reader in
                if reader.frame(in: .global).minY > -300 {
                    KFImage(viewModel.getHeaderImageURL())
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .offset(y: -reader.frame(in: .global).minY)
                        .frame(width: UIScreen.main.bounds.width, height: reader.frame(in: .global).minY + 300)
                        .overlay(
                            HStack {
                                Spacer()
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "xmark.circle")
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                        .foregroundColor(.white)
                                        .shadow(radius: 4)
                                }
                            }
                            .offset(y: -reader.frame(in: .global).minY)
                            .padding(.horizontal)
                            .padding(.top, 50),
                            alignment: .top
                        )
                }
            }
            .frame(height: 300)
            VStack(alignment: .leading) {
                Text(viewModel.doc.name ?? "")
                    .font(.largeTitle)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 25)
            .padding(.horizontal)
            .background(Color(.systemBackground))
            .cornerRadius(25)
            .offset(y: -35)
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
    }
}
