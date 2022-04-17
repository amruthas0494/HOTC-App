//
//  EventVideoListViewController.swift
//  HOTCC
//
//  Created by apple on 27/10/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer

class EventVideoListViewController: UIViewController {
    let step:Float=10

    private lazy var player: AVPlayer = .init()
    var playeaudio: AVAudioPlayer?
    var playerLayer: AVPlayerLayer?
    private var fadeTimer: Timer?
    var playercontroller = AVPlayerViewController()
    var playVideo : AVPlayer?
    var labelName : String?
    var displayImage : String?
    var sharedVideos : [String] = []
    var muhuratsharedvideo : [String] = []
    var preWeddingsharedvideo : [String] = []
    var receptionsharedvideo : [String] = []
    var mehandisharedvideo : [String] = []
    var sangeetsharedvideo : [String] = []
  
    
    let mpVolumeView:MPVolumeView = {
        let view = MPVolumeView()
        return view
    }()
    var allThumbnails : [UIImage] = []
    let sectionInsets = UIEdgeInsets(
        top: 5.0,
        left: 5.0,
        bottom: 5.0,
        right:5.0)
    let button: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "video_player-1"), for: .normal)
        btn.backgroundColor = .white
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    var mySlider:UISlider?
    var volume: MPVolumeView?
    var myView = UIView()
    var mpVolumeHolderView = UIView()
    
    @IBOutlet weak var displayBackground: UIImageView!
    
    @IBAction func videolistBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func videoHomeButtonTapped(_ sender: UIButton) {
        let vc = DisplayFolderViewController.instantiate(fromStoryboard: .Main)
       
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBOutlet weak var folderName: UILabel!
    @IBOutlet weak var eventVideoList: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayBackground.image = UIImage(contentsOfFile: displayImage!)
        self.displayBackground.autoresizingMask =  [.flexibleTopMargin, .flexibleHeight, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleWidth]
     
        self.displayBackground.contentMode = UIView.ContentMode.scaleAspectFill
        self.folderName.text = labelName
        mySlider = UISlider(frame:CGRect(x: 0, y: 15, width: 150, height: 10))
        mySlider?.minimumValue = 0.0
        mySlider?.maximumValue = 1.0
        mySlider?.isSelected = true
        mySlider?.maximumTrackTintColor = UIColor.white
        mySlider?.minimumTrackTintColor = UIColor.white
        mySlider?.isContinuous = true
        mySlider?.tintColor = UIColor.white
        mySlider?.thumbTintColor = UIColor.white
        
        myView = UIView(frame: CGRect(x: 500, y: 30, width: 150, height: 40))
        myView.backgroundColor = UIColor.gray
        myView.layer.cornerRadius = 20
        myView.clipsToBounds = true
        
    }
    
}


extension EventVideoListViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return allThumbnails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.eventVideoList.dequeueReusableCell(withReuseIdentifier: "eventVideoList", for: indexPath) as! EventVideoCollectionViewCell
        if allThumbnails != nil {
        cell.displayTumbnail.image = allThumbnails[indexPath.item]
        }
        else {
            cell.displayTumbnail.image = UIImage(named: "Wedding.jpg")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        player = AVPlayer(url: URL(fileURLWithPath: sharedVideos[indexPath.item]))
        playercontroller.player = player
        self.playercontroller.modalPresentationStyle = .overFullScreen
        
        playercontroller.player = player
        
        //playercontroller.player?.volume = MPVolumeView.setVolume(0.8)
        mpVolumeHolderView = UIView(frame: CGRect(x: 500, y:30, width: 150, height: 40))
        mpVolumeHolderView.layer.cornerRadius = 20
        // Set the holder view's background color to transparent
        mpVolumeHolderView.backgroundColor = .black
        let mpVolume = MPVolumeView(frame: mpVolumeHolderView.bounds)
        mpVolume.showsRouteButton = true
        
     
        mpVolumeHolderView.addSubview(mpVolume)
        mpVolumeHolderView.bringSubviewToFront(mpVolume)
        
        self.playercontroller.showsPlaybackControls = true
        
        
        mySlider!.addTarget(playercontroller.self, action: #selector(sliderValueDidChange(_:)), for: .allEvents)
        //  self.playercontroller.player?.volume = mySlider?.value
        self.present(self.playercontroller, animated: true, completion: {
            self.playercontroller.player?.play()
            
            // Fade player volume from 0 to 1 in 5 seconds
            
        })
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playercontroller.player?.currentItem)
    
        
    }
    @objc func playerDidFinishPlaying(note: NSNotification) {
        playercontroller.dismiss(animated: true, completion: nil)
    }
    @objc func sliderValueDidChange(_ sender:UISlider!)
    {
        player.volume = mySlider!.value;
        print("Slider value changed")
        
        // Use this code below only if you want UISlider to snap to values step by step
        let roundedStepValue = round(sender.value / Float(step)) + step
        sender.value = roundedStepValue
        
        print("Slider step value \(Int(roundedStepValue))")
    }
   
    
    func playSound(audioURL: URL?, setVolume: Bool = false, level: Float = 1.0) {
        if let audioUrl = audioURL {
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: .mixWithOthers) //For playing volume when phone is on silent
                try AVAudioSession.sharedInstance().setActive(true)
                
                var volumeSlider: UISlider = UISlider()
                volumeSlider = UISlider(frame:CGRect(x: 500, y: 100, width: 300, height: 10))
                volumeSlider.minimumValue = 0
                volumeSlider.maximumValue = 100
                volumeSlider.isContinuous = true
                volumeSlider.tintColor = UIColor.white
                playercontroller.contentOverlayView?.addSubview(volumeSlider)
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
                print(error.localizedDescription)
            }
            
        }
        
    }
    
}


extension EventVideoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 400, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
        
    }
}

extension MPVolumeView {
    var volumeSlider:UISlider {
        self.showsRouteButton = false
        self.showsVolumeSlider = true
        
        var slider = UISlider()
        for subview in self.subviews {
            if subview.isKind(of: UISlider.self){
                slider = subview as! UISlider
                slider = UISlider(frame:CGRect(x: 0, y: 15, width: 100, height: 10))
                slider.isContinuous = false
                slider.minimumTrackTintColor = UIColor.blue
                slider.tintColor = .white
                slider.minimumTrackTintColor = UIColor.lightGray
                (subview as! UISlider).value = AVAudioSession.sharedInstance().outputVolume
                return slider
            }
        }
        return slider
    }
}


extension AVPlayer {
    
    func fadeVolume(from: Float, to: Float, duration: Float, completion: (() -> Void)? = nil) -> Timer? {
    
        volume = from
        guard from != to else { return nil }
        
        let interval: Float = 0.1
        
        let range = to-from
     
        let step = (range*interval)/duration
        func reachedTarget() -> Bool {
          
            
            guard volume >= 0, volume <= 1 else {
                volume = to
                return true
            }
           
            if to > from {
                return volume >= to
            }
            return volume <= to
        }
       
        return Timer.scheduledTimer(withTimeInterval: Double(interval), repeats: true, block: { [weak self] (timer) in
            guard let self = self else { return }
            DispatchQueue.main.async {
               
                if !reachedTarget() {
                    
                    self.volume += step
                } else {
                    timer.invalidate()
                    completion?()
                }
            }
        })
        
    }
}
