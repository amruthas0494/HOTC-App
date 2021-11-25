//
//  PlayVideoViewController.swift
//  Photography-HOTC
//
//  Created by apple on 28/10/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer

class PlayVideoViewController: UIViewController,  AVPlayerViewControllerDelegate {
    let step:Float=10
    var playVideoNow: String?
    // var player = AVPlayer()
    private lazy var player: AVPlayer = .init()
    private var fadeTimer: Timer?
    var playercontroller = AVPlayerViewController()
    
    let button: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "video_player-1"), for: .normal)
        btn.backgroundColor = .white
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    var mySlider:UISlider?
    @IBOutlet weak var viewFullVideo: PlayVideoClass!
    
    
    @IBAction func videoBackGo(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func homaButtonTapped(_ sender: UIButton) {
        let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeScreen") as?  DisplayFolderViewController
        
        self.present(viewcontroller!, animated: true, completion: nil)
        
        
        
    }
    
    
   
    @objc func playerDidFinishPlaying(note: NSNotification) {
        playercontroller.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let player = AVPlayer(url: URL(fileURLWithPath: playVideoNow!))
        let playerLayer = AVPlayerLayer(player: player)
        player.volume = 0
        // fadeTimer = player.fadeVolume(from: 0, to: 1, duration: 5)
        playerLayer.frame = self.view.bounds
        // playerLayer.videoGravity = .resize
        viewFullVideo.layer.addSublayer(playerLayer)
        playerLayer.frame = viewFullVideo.layer.bounds
        self.view.layer.addSublayer(playerLayer)
        button.frame = CGRect(x: 30, y: 100, width: 50, height: 50)
        button.layer.cornerRadius = button.frame.width/2
        button.setImage(UIImage(systemName: "arrow.up.left.and.arrow.down.right"), for: .normal)
        self.view.addSubview(button)
        
        mySlider = UISlider(frame:CGRect(x: 500, y: 100, width: 300, height: 10))
        mySlider?.minimumValue = 0
        mySlider?.maximumValue = 100
        mySlider?.isContinuous = true
        mySlider?.tintColor = UIColor.white
        self.view.addSubview(mySlider!)
        mySlider?.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        player.play()
        button.addTarget(self, action: #selector(videoPlay), for: .touchUpInside)
    }
    
    @objc func sliderValueDidChange(_ sender:UISlider!)
    {
        player.volume = mySlider!.value
                print("Slider value changed")
      
    }
    @objc func videoPlay() {
        player = AVPlayer(url: URL(fileURLWithPath: playVideoNow!))
        self.playercontroller.player = self.player
        //   player.volume = mySlider
        
        playSound(audioURL: URL(fileURLWithPath: playVideoNow!), setVolume: true, level: 1.0)
        self.playercontroller.modalPresentationStyle = .overFullScreen
        playercontroller.contentOverlayView?.frame = self.view.bounds
        playercontroller.contentOverlayView?.addSubview(mySlider!)
        // self.playercontroller.addSubview(mySlider)
        //  playercontroller.frame = self.view.bounds
        
        
        self.playercontroller.showsPlaybackControls = true
        
        self.present(self.playercontroller, animated: true, completion: {
            DispatchQueue.main.async {
                self.playercontroller.player?.play()
            }
            
        })
        
    }
    func playSound(audioURL: URL?, setVolume: Bool = false, level: Float = 1.0) {
        if let audioUrl = audioURL {
            do {
                
                var volumeSlider: UISlider = UISlider()
                var origVolume: Float = 0.0
                if (setVolume) {
                    // Save the original volume level, then turn up the system volume
                    volumeSlider = (MPVolumeView().subviews.filter{NSStringFromClass($0.classForCoder) == "MPVolumeSlider"}.first) as! UISlider
                    origVolume = AVAudioSession.sharedInstance().outputVolume
                    volumeSlider.setValue(level, animated: false)
                }
                
                // Sound the alarm
                let player = try AVAudioPlayer(contentsOf: audioUrl)
                DispatchQueue.main.asyncAfter(deadline: .now() + player.duration) {
                    // Capture the AVPlayer instance in this closure to ensure is remains in scope until playback finishes
                    _ = player
                    if (setVolume) {
                        // After the duration of the audio, turn set the volume back to the previous level
                        volumeSlider.setValue(origVolume, animated: false)
                        
                    }
                }
                player.play()
            } catch {
                print(error)
            }
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        // videoPlay()
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playercontroller.player?.currentItem)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        
        
    }
    
}
