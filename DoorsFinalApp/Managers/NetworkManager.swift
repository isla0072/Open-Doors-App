//
//  NetworkManager.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-12-06.
//

import Firebase
import Network

class NetworkManager: ObservableObject {
    let monitor = NWPathMonitor()
    @Published var isConnected = false

    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}
