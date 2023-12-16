//
//  MoreView.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-11-30.
//

import SwiftUI

struct MoreView: View {
    @ObservedObject var languagesManager: LanguagesManager

    private var headerView: some View {
        HStack {
            Image("ic_logo")
                .resizable()
                .frame(width: 70, height: 50)
            Text("More")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.blue)
        .foregroundColor(.white)
    }

    var body: some View {
        NavigationView {
            VStack {
                headerView
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Languages")
                            .font(.headline)
                            .bold()
                        Spacer()
                        Picker("Language", selection: $languagesManager.currentLanguage) {
                            Text("English").tag("en")
                            Text("French").tag("fr")
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    Divider()
                    NavigationLink(destination: AboutView()) {
                        HStack {
                            Text("About You")
                                .foregroundColor(.black)
                                .font(.headline)
                                .bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    Divider()
                    NavigationLink(destination: RecommendView(networkManager: NetworkManager())) {
                                HStack {
                                    Text("Recommend a Building")
                                                    .foregroundColor(.black)
                                                    .font(.headline)
                                                    .bold()
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                            }
                                        }
                }
                .padding()
                Spacer()
            }
        }
    }
}
