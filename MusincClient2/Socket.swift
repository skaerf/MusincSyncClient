//
//  Socket.swift
//  MusincClient2
//
//  Created by Lawrence Harrison on 09/12/2022.
//

import Foundation
import UIKit
import SocketIO


@objc class Utility: NSObject{
    static let main = Utility()
    fileprivate override init() {}
}


class ServerSocket: NSObject {

    open class SocketConnection {

        public static let default_ = SocketConnection()
        let manager: SocketManager
        private init() {
            let param:[String:Any] = [:]
            let route = "82.5.156.234:1905"
            let socketURL: URL = Utility.URLforRoute(route: route, params: param)! as URL
            manager = SocketManager(socketURL: socketURL, config: [.log(true), .compress])
            manager.config = SocketIOClientConfiguration(arrayLiteral: .connectParams(param), .secure(true))
        }
    }
    private func connectSocket() {
        let socket = SocketConnection.default_.manager.defaultSocket
        if socket.status != .connected {
            socket.connect()
        }
        socket.on(clientEvent: .connect) {data, ack in

            print(data)
            print(ack)
            print("socket connected")
            self.getFinishAcknowledgement()
        }
        socket.on(clientEvent: .disconnect) {data, ack in

        }
        socket.on("unauthorized") { (data, ack) in
            print(data)
            print(ack)
            print("unauthorized user")
        }
    }
    private func disconnectSocket() {
        let socket = SocketConnection.default_.manager.defaultSocket
        socket.disconnect()
    }
    private func getFinishAcknowledgement() {
        let socket = SocketConnection.default_.manager.defaultSocket
        socket.on("Acknowledgement") {data, ack in
            print(data)
            socket.disconnect()
        }
    }
}


extension Utility {
    static func URLforRoute(route: String,params:[String: Any]) -> NSURL? {
        if let components: NSURLComponents  = NSURLComponents(string: route){
            var queryItems = [NSURLQueryItem]()
            for(key,value) in params {
                queryItems.append(NSURLQueryItem(name:key,value: "\(value)"))
            }
            components.queryItems = queryItems as [URLQueryItem]?
            return components.url as NSURL?
        }
        return nil
    }
}
