//
//  ContentView.swift
//  SwiftUIWebSockets
//
//  Created by Angelos Staboulis on 16/11/24.
//

import SwiftUI

struct ContentView: View {
    @State var message:String
    @State var websocket = WebSockets()
    @State var messages:[String]
    var body: some View {
        NavigationStack{
            VStack {
                List(messages,id:\.self){item in
                    Text(item)
                }
                HStack{
                    TextField("Enter your message", text: $message).frame(width:200)
                    VStack{
                        Button {
                            websocket.connect()
                            Task{
                                await websocket.readMessage()
                            }
                            
                        } label: {
                            Text("Connect ")
                        }.frame(width:130,alignment:.leading)
                        Button {
                            websocket.sendMessage(message)
                            Task{
                                messages.append(await websocket.readMessage())
                                
                            }
                            
                        } label: {
                            Text("Send Message")
                        }.frame(width:130,alignment:.leading)
                    }
                }
                
            }.navigationTitle("WebSockets")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView(message: "", websocket: .init(), messages: [])
}
