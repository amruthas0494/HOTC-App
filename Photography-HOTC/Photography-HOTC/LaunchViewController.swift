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
    
    @IBOutlet weak var launchView: UIView!
    func setupAVPlayer() {
        
        let videoURL = Bundle.main.url(forResource: "HOTC", withExtension: "mov") // Get video url
        let avAssets = AVAsset(url: videoURL!)
        let avPlayer = AVPlayer(url: videoURL!)
        let avPlayerLayer = AVPlayerLayer(player: avPlayer)
        
        avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avPlayerLayer.frame = self.launchView.frame
        
        DispatchQueue.main.async {
            self.launchView.layer.addSublayer(avPlayerLayer)
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
        let manager = FileManager.default
   
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setupAVPlayer()
    }
    
}
