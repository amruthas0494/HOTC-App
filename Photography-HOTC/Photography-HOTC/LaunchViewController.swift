//
//  LaunchViewController.swift
//  Photography-HOTC
//
//  Created by apple on 29/10/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

import AVFoundation

class LaunchViewController: UIViewController {
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    func setupAVPlayer() {
        
        let videoURL = Bundle.main.url(forResource: "HOTC", withExtension: "mov") // Get video url
        let avAssets = AVAsset(url: videoURL!)
        let avPlayer = AVPlayer(url: videoURL!)
        let avPlayerLayer = AVPlayerLayer(player: avPlayer)
        
        avPlayerLayer.videoGravity = .resizeAspectFill
        avPlayerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(avPlayerLayer)
        DispatchQueue.main.async {
            avPlayer.play()
        }
        
        
        
        avPlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1) , queue: .main) { [weak self] time in
            
            if time == avAssets.duration {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeScreen") as! DisplayFolderViewController
                self?.present(vc, animated: true, completion: nil)
                //self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setupAVPlayer()
    }
    
}
