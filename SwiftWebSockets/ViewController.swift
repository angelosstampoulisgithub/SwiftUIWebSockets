//
//  ViewController.swift
//  SwiftWebSockets
//
//  Created by Angelos Staboulis on 16/11/24.
//

import UIKit
import Starscream
class WebSockets:WebSocketDelegate{
    private var webSocket: WebSocket?
    init(){
        connect()
    }
    private func connect() {
        let url = URL(string: "ws://echo.websocket.org")!
        let request = URLRequest(url: url)
        webSocket = WebSocket(request: request)
        webSocket?.delegate = self
        webSocket?.connect()
    }
    func didReceive(event: WebSocketEvent, client: any WebSocketClient) {
        switch event {
        case .connected(let headers):
          print("connected \(headers)")
        case .disconnected(let reason, let closeCode):
          print("disconnected \(reason) \(closeCode)")
        case .text(let text):
          print("received text: \(text)")
        case .binary(let data):
          print("received data: \(data)")
        case .pong(let pongData):
            print("received pong: \(String(describing: pongData))")
        case .ping(let pingData):
            print("received ping: \(String(describing: pingData))")
        case .error(let error):
            print("error \(String(describing: error))")
        case .viabilityChanged:
          print("viabilityChanged")
        case .reconnectSuggested:
          print("reconnectSuggested")
        case .cancelled:
          print("cancelled")
        case .peerClosed:
          print("peerClosed")
        }
    }
    func sendMessage(message:String){
        webSocket?.write(string: message, completion: {
            debugPrint("completed")
        })
    }
    func close(){
        webSocket?.disconnect()
    }
}
class ViewController: UIViewController {
    let webSocket = WebSockets()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        webSocket.sendMessage(message: "Hello ther i am Angelos")
        webSocket.close()
    }

}

