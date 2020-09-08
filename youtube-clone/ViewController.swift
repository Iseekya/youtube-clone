//
//  ViewController.swift
//  youtube-clone
//
//  Created by Stefan Hitrov on 8.09.20.
//  Copyright © 2020 Stefan Hitrov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var model = Model()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.getVideos()
        
    }


}

