//
//  SwiftUIWebSocketsApp.swift
//  SwiftUIWebSockets
//
//  Created by Angelos Staboulis on 16/11/24.
//

import SwiftUI

@main
struct SwiftUIWebSocketsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(message: "", websocket: .init(), messages: [])
        }
    }
}
