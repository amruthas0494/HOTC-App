//
//  ViewController.swift
//  Photography-HOTC
//
//  Created by apple on 27/10/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class ViewController: UIViewController {

    var player = AVPlayer()
    var playercontroller = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let videoPath = Bundle.main.path(forResource: "Mehandi", ofType: "mp4")
        let avPlayer = URL(fileURLWithPath: videoPath!)
        player = AVPlayer(url: avPlayer)
        playercontroller.player = player
       
   
    }
    override func viewDidAppear(_ animated: Bool) {
         self.present(playercontroller, animated: true, completion: nil)
    }

}

