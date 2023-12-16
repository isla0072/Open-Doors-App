//
//  AboutView.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-11-20.
//

import SwiftUI

struct AboutView: View {
    var name: String = "Abir Islah"
    var email: String = "isla0072@algonquinlive.com"
    var github: String = "https://github.com/isla0072"
    var image: Image = Image("about")

    var body: some View {
        VStack { 
            image
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(name)
                .font(.title)
            Divider()
            HStack {
            Image(systemName: "envelope")
                .foregroundColor(.gray)
            Text(email)
                .font(.subheadline)
            }
            Divider()
            HStack {
            Image(systemName: "link")
                .foregroundColor(.gray)
            Link(destination: URL(string: github)!, label: {
            Text(github)
                .font(.subheadline)
                })
            }
            Spacer()
        }
        .padding()
        .navigationTitle("About You")
    }
}
