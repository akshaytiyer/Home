//
//  LiveViewController.swift
//  Home
//
//  Created by Akshay Iyer on 5/1/17.
//  Copyright © 2017 akshaytiyer. All rights reserved.
//

import UIKit
class LiveViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.urlTextField.delegate = self;
        self.urlTextField.layer.cornerRadius = 10.0
    }
    
    
    @IBAction func LiveButton(_ sender: Any) {
        let youTubeURL = "youtube://www.youtube.com/watch?v=" + urlTextField.text!
        let url = NSURL(string: youTubeURL)!
        UIApplication.shared.open(url as URL)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
