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
    var window: UIWindow?
    
    var player: AVPlayer?
    var playerLayer =  AVPlayerLayer()
    
    @IBOutlet weak var launchView: UIView!
    func setupAVPlayer() {
        
        let videoURL = Bundle.main.url(forResource: "HOTC", withExtension: "mov") // Get video url
        let avAssets = AVAsset(url: videoURL!)
        let avPlayer = AVPlayer(url: videoURL!)
       playerLayer = AVPlayerLayer(player: avPlayer)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
      
        
        DispatchQueue.main.async {
            self.view.layer.addSublayer(self.playerLayer)
            avPlayer.play()
        }
        
        
        
        avPlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1) , queue: .main) { [weak self] time in
            
            if time == avAssets.duration {
//                let navController: UINavigationController!
//                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeScreen") as! DisplayFolderViewController
//               // navController = UINavigationController(rootViewController: vc)
//               // navController.isNavigationBarHidden = true
//                self?.present(vc, animated: true, completion: nil)
//
                //self?.navigationController?.pushViewController(vc, animated: true)
                let vc = DisplayFolderViewController.instantiate(fromStoryboard: .Main)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        playerLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAVPlayer()
       
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.setupAVPlayer()
    }
    
}
