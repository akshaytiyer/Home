//
//  HomeViewController.swift
//  Home
//
//  Created by Akshay Iyer on 3/22/17.
//  Copyright © 2017 akshaytiyer. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var imageVRView: GVRPanoramaView!
    @IBOutlet var videoVRView: GVRVideoView!
    @IBOutlet var imageLabel: UILabel!
    @IBOutlet var videoLabel: UILabel!
    
    enum Media {
        static var photoArray = ["sindhu_beach.jpg", "grand_canyon.jpg", "underwater.jpg"]
        static let videoURL = "https://s3.amazonaws.com/ray.wenderlich/elephant_safari.mp4"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageVRView.load(UIImage(named: Media.photoArray.first!),
                         of: GVRPanoramaImageType.mono)
        videoVRView.load(from: URL(string: Media.videoURL))
        
        imageVRView.enableCardboardButton = true
        imageVRView.enableFullscreenButton = true
        
        videoVRView.enableCardboardButton = true
        videoVRView.enableFullscreenButton = true
        
    }
}
