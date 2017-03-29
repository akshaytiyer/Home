//
//  InterfaceController.swift
//  Home Watch Kit Extension
//
//  Created by Akshay Iyer on 3/28/17.
//  Copyright © 2017 akshaytiyer. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @available(watchOS 2.2, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    var session: WCSession!
    
    @IBOutlet var messageLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if(WCSession.isSupported())
        {
            self.session = WCSession.default()
            self.session.delegate = self
            self.session.activate()
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func sendMessageToWatch() {
        session.sendMessage(["b":"GoodBye"], replyHandler: nil, errorHandler: nil)  
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        //Recieve a Message
        self.messageLabel.setText(message[
            "a"]! as? String)
        
    }
}
