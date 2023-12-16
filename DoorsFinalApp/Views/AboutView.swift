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
            Text(email)
                .font(.subheadline)
            Spacer()
        }
        .padding()
        .navigationTitle("About You")
    }
}
