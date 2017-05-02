//
//  BoxViewController.swift
//  Home
//
//  Created by Akshay Iyer on 5/2/17.
//  Copyright © 2017 akshaytiyer. All rights reserved.
//

import UIKit

class BoxViewController: UIViewController
{
    
    @IBOutlet var imageVRView: GVRPanoramaView!
    override func viewDidLoad() {
        imageVRView.load(UIImage(named: "IMG_3236.JPG"),
                         of: GVRPanoramaImageType.mono)
        imageVRView.enableCardboardButton = true
        imageVRView.enableFullscreenButton = true
    }
}
