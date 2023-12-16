//
//  RecommendedView.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-12-06.
//

import SwiftUI

struct RecommendView: View {
    @State private var name = ""
    @State private var category = ""
    @State private var description = ""
    @State private var showAlert = false
    @State private var recommendationAdded = false

    @ObservedObject var networkManager = NetworkManager()

    var body: some View {
        NavigationView {
            Form {
                TextField("Name of the building", text: $name)
                TextField("Category", text: $category)
                TextField("Description", text: $description)

                Button("Recommend Building") {
                    if networkManager.isConnected {
                        recommendationAdded = false
                        FirebaseManager.addRecommendation(name: name, category: category, description: description) {
                            DispatchQueue.main.async {
                                recommendationAdded = true
                            }
                        }
                    } else {
                        self.showAlert = true
                    }
                }
                .disabled(!networkManager.isConnected)
            }
            .navigationBarTitle("Recommend a Building")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("There is no Internet Connection"),
                      message: Text("Please check your internet connection and try again."),
                      dismissButton: .default(Text("Ok")))
            }
            .alert(isPresented: $recommendationAdded) {
                            Alert(title: Text("Thank you"),
                                  message: Text("The building recommendation was added succesfully."),
                                  dismissButton: .default(Text("Done")))
            }
        }
    }
}
