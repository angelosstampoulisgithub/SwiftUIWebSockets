//
//  WebSockets.swift
//  SwiftUIWebSockets
//
//  Created by Angelos Staboulis on 16/11/24.
//

import Foundation
import SwiftUI
@MainActor
class WebSockets:ObservableObject {
    
    private var webSocketTask: URLSessionWebSocketTask?

    func connect() {
        guard let url = URL(string: "wss://echo.websocket.org") else { return }
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        webSocketTask = URLSession.shared.webSocketTask(with: request)
        webSocketTask?.resume()
        
    }
    func close(){
        let reason = "Closing connection".data(using: .utf8)
        webSocketTask?.cancel(with: .goingAway, reason: reason)
    }
    func readMessage() async -> String{
        return await withCheckedContinuation { continuation in
            webSocketTask!.receive { result in
                switch result {
                case .failure(let error):
                    print("Failed to receive message: \(error)")
                case .success(let message):
                    switch message {
                    case .string(let text):
                             print("Received text message: \(text)")
                            continuation.resume(returning: text)
                    case .data(let data):
                        print("Received binary message: \(data)")
                    @unknown default:
                        fatalError()
                    }
                }
             
        }
     }


    }
    func sendMessage(_ message: String) {
        let webMessage = URLSessionWebSocketTask.Message.string(message)
        webSocketTask!.send(webMessage) { error in
            if let error = error {
                print("WebSocket sending error: \(error)")
            }else{
                print("Completed successfully")
            }
        }
    }
}


