//
//  FirebaseManager.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-12-06.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseManager {
    static func addRecommendation(name: String, category: String, description: String, completion: @escaping () -> Void) {
        let db = Firestore.firestore()
        db.collection("buildings").addDocument(data: [
            "name": name,
            "category": category,
            "description": description
        ]) { error in
            if let error = error {
                print("There was an error when adding the document: \(error)")
            } else {
                print("The document was added successfully.")
                completion()
            }
        }
    }
}

