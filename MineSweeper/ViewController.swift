//
//  ViewController.swift
//  MineSweeper
//
//  Created by BRIAN WANG on 3/5/24.
//

import UIKit
class delegate {
    static var size = 0
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func easyAction(_ sender: Any) {
        delegate.size = 5
    }
    @IBAction func MediumAction(_ sender: Any) {
        delegate.size = 7
    }
    @IBAction func hardAction(_ sender: Any) {
        delegate.size = 9
    }
    
}

