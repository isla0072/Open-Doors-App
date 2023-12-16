//
//  LanguagesManager.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-12-08.
//

import Foundation

class LanguagesManager: ObservableObject {
    @Published var currentLanguage: String = "en" {
        didSet {
            NotificationCenter.default.post(name: .languageDidChange, object: nil)
        }
    }
}

extension Notification.Name {
    static let languageDidChange = Notification.Name("LanguageManagerLanguageDidChange")
}

