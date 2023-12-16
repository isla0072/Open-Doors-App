//
//  DoorsFinalAppApp.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-11-20.
//

import SwiftUI
import Firebase

@main
struct DoorsFinalAppApp: App {
    
    init() {
            FirebaseApp.configure()
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()      }
    }
}
