//
//  SearchBarView.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-11-20.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String

    var body: some View {
        TextField("Search the buildings", text: $text)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image("search")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    if !text.isEmpty {
                        Button(action: { self.text = "" }) {
                            Image(systemName: "xmark.circle.fill")
                        }
                    }
                }
                .padding(.horizontal, 8)
                .foregroundColor(.gray)
            )
            .padding(.horizontal, 10)
    }
}
