//
//  HomeViewController.swift
//  Home
//
//  Created by Akshay Iyer on 3/22/17.
//  Copyright © 2017 akshaytiyer. All rights reserved.
//

import UIKit
import WatchConnectivity
import CoreMotion

class HomeViewController: UIViewController, WCSessionDelegate {
    
    @available(iOS 9.3, *)
    public func sessionDidDeactivate(_ session: WCSession) {
    }
    
    @available(iOS 9.3, *)
    public func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    @available(iOS 9.3, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    var motionManager = CMMotionManager()
    var previousValue = 0.0
    var nextValue = 0.0
    
    @IBOutlet var imageVRView: GVRPanoramaView!
    @IBOutlet var videoVRView: GVRVideoView!
    @IBOutlet var imageLabel: UILabel!
    @IBOutlet var videoLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    var session: WCSession!
    
    enum Media {
        static var photoArray = ["sindhu_beach.jpg", "grand_canyon.jpg", "underwater.jpg"]
        static let videoURL = "https://s3.amazonaws.com/ray.wenderlich/elephant_safari.mp4"
    }
    
    var currentView: UIView?
    var currentDisplayMode = GVRWidgetDisplayMode.embedded
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        if(WCSession.isSupported())
        {
            self.session = WCSession.default()
            self.session.delegate = self
            self.session.activate()
        }
        
        imageLabel.isHidden = true
        imageVRView.isHidden = true
        videoLabel.isHidden = true
        videoVRView.isHidden = true
        
        imageVRView.load(UIImage(named: Media.photoArray.first!),
                         of: GVRPanoramaImageType.mono)
        imageVRView.enableCardboardButton = true
        imageVRView.enableFullscreenButton = true
        imageVRView.delegate = self
        
        videoVRView.load(from: URL(string: Media.videoURL))
        videoVRView.delegate = self
        videoVRView.enableCardboardButton = true
        videoVRView.enableFullscreenButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        motionManager.accelerometerUpdateInterval = 0.3
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let myData = data
            {
                //print(myData)
                //print(self.calendar.component(.second, from: self.date))
                if self.previousValue != 0.0 {
                    if myData.acceleration.z > -0.3 && myData.acceleration.z < 0.3  {
                        if self.currentView == self.imageVRView {
                            Media.photoArray.append(Media.photoArray.removeFirst())
                            self.imageVRView?.load(UIImage(named: Media.photoArray.first!),
                                              of: GVRPanoramaImageType.mono)
                        }
                        self.previousValue=0.0
                    }
                    else {
                        
                        self.previousValue=0.0
                    }
                }
                
                if self.nextValue != 0.0 {
                    print(myData.acceleration.z)
                    if myData.acceleration.z > -0.2 && myData.acceleration.z < 0.1  {
                        print("Rugved")
                        self.nextValue=0.0
                    }
                    else {
                        self.nextValue=0.0
                    }
                }
                
                if myData.acceleration.z < -0.8
                {
                    self.previousValue = myData.acceleration.z
                    
                }
                else if myData.acceleration.z > 0.2
                {
                    self.nextValue = myData.acceleration.z
                    
                }
            }
        }
    }
    
    @IBAction func sendMessagetoHome(_ sender: Any) {
        session.sendMessage(["a" : "Hello"], replyHandler: nil, errorHandler: nil)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        //Handle Messages from the watch
        self.messageLabel.text = message["b"]! as? String
        if self.messageLabel.text == "GoodBye"
        {
            if currentView == imageVRView {
                Media.photoArray.append(Media.photoArray.removeFirst())
                imageVRView?.load(UIImage(named: Media.photoArray.first!),
                                  of: GVRPanoramaImageType.mono)
            }
        }
    }
}

extension HomeViewController: GVRWidgetViewDelegate {
    func widgetView(_ widgetView: GVRWidgetView!, didLoadContent content: Any!) {
        if content is UIImage {
            imageVRView.isHidden = false
            imageLabel.isHidden = false
        } else if content is NSURL {
            videoVRView.isHidden = false
            videoLabel.isHidden = false
        }
    }
    
    func widgetView(_ widgetView: GVRWidgetView!, didFailToLoadContent content: Any!,
                    withErrorMessage errorMessage: String!)  {
        print(errorMessage)
    }
    
    func widgetView(_ widgetView: GVRWidgetView!, didChange displayMode: GVRWidgetDisplayMode) {
        currentView = widgetView
        currentDisplayMode = displayMode
        if currentView == imageVRView && currentDisplayMode != GVRWidgetDisplayMode.embedded {
            view.isHidden = true
        } else {
            view.isHidden = false
        }
    }
    
    func widgetViewDidTap(_ widgetView: GVRWidgetView!) {
        // 1
        guard currentDisplayMode != GVRWidgetDisplayMode.embedded else {return}
        // 2
        if currentView == imageVRView {
            Media.photoArray.append(Media.photoArray.removeFirst())
            imageVRView?.load(UIImage(named: Media.photoArray.first!),
                              of: GVRPanoramaImageType.mono)
        }
    }
}
