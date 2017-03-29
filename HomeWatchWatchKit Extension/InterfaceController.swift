//
//  InterfaceController.swift
//  HomeWatchWatchKit Extension
//
//  Created by Akshay Iyer on 3/28/17.
//  Copyright © 2017 akshaytiyer. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {

    var watchSession: WCSession!
    
    
    override func willActivate() {
        super.willActivate()
        watchSession = WCSession.default()
        watchSession.delegate = self
        watchSession.activate()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print(message)
    }
    
    @IBAction func nextImage() {
        let message = ["Message":"Next Video"]
        
        watchSession.sendMessage(message, replyHandler: nil) { error in
            print(error.localizedDescription)
        }
    }
    
}

extension InterfaceController: WCSessionDelegate {
    
    @available(watchOS 2.2, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    
}
