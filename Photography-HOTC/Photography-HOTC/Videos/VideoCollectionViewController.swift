//
//  VideoCollectionViewController.swift
//  HOTCC
//
//  Created by apple on 26/10/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

class VideoCollectionViewController: UIViewController {
    
    @IBOutlet weak var videoCollection: UICollectionView!
    
    @IBOutlet weak var displayFolderName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var eventvideos = [Video]()
    var backgroundImage: String = ""
    var updatedbackground = ""
    var videoImage = ""
    var eventname: String = ""
    var videoFolders:[String] = []
    var videoBackground:[String] = []
    var bgVideoArray : [UIImage] = []
    
    var fileName:String?
    var filenames : [String] = []
    var backgroundFolder :Background?
    var backgroundImages: [UIImage] = []
    
    var haldiVideos: [String] = []
    var muhuratVideos: [String] = []
    var preweddingVideos: [String] = []
    var receptionVideos: [String] = []
    var mehandiVideos: [String] = []
    var sangeetVideos: [String] = []
    var haldiThumbnail : [String] = []
    var MuhuratThumbnail : [String] = []
    var receptionThumbail : [String] = []
    var preweddingThumbnail : [String] = []
    var mehandiThumbnail : [String] = []
    var sangeetThumbnail : [String] = []
    
    var haldiNewThumbnail : [UIImage] = []
    
    var MuhuratNewThumbnail : [UIImage] = []
    var receptionNewThumbail : [UIImage] = []
    var preweddingNewThumbnail : [UIImage] = []
    var mehandiNewThumbnail : [UIImage] = []
    var sangeetNewThumbnail : [UIImage] = []
    
    var hThumbnail : [UIImage] = []
    
    var MThumbnail : [UIImage] = []
    var rThumbail : [UIImage] = []
    var pThumbnail : [UIImage] = []
    var mThumbnail : [UIImage] = []
    var sThumbnail : [UIImage] = []
    
    
    var updatedhaldivideos : [String] = []
    var updatedmuhuratvideos : [String] = []
    var updatedpreweddingvideos : [String] = []
    var updatedreceptionvideos : [String] = []
    var updatedmehandivideos : [String] = []
    var updatedsangeetvideos : [String] = []
    
    var uniquehaldiFolder : [String] = []
    var uniquemuhuratFolder : [String] = []
    var uniquepreweddingFolder : [String] = []
    var uniquereceptionFolder : [String] = []
    var uniquemehandiFolder : [String] = []
    var uniquesangeetFolder : [String] = []
    
    
    let sectionInsets = UIEdgeInsets(
        top: 5.0,
        left: 5.0,
        bottom: 5.0,
        right:5.0)
    
    
    @IBAction func videoBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func homeTapped(_ sender: UIButton) {
        let vc = DisplayFolderViewController.instantiate(fromStoryboard: .Main)
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("video added",eventvideos)
       print(backgroundFolder)
        
    /*
        for image in background {
            if let data = try? Data(contentsOf: image)
            {
                let image: UIImage = UIImage(data: data)!
                self.backgroundImages.append(image)
                
            }
        }
        getVideosFolderNames()
        getcollectionbackground()
        getHaldiVideos()
        getmuhuratVideos()
        getpreweddingVideo()
        getreceptionVideo()
        getMehandiVideo()
        getSangeetVideo() */
        DispatchQueue.main.async {
            self.displayFolderName.text = self.videoImage
            self.imageView.image = UIImage(contentsOfFile: self.backgroundImage)
            self.imageView.autoresizingMask =  [.flexibleTopMargin, .flexibleHeight, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleWidth]
         
            self.imageView.contentMode = UIView.ContentMode.scaleAspectFill
        }
        
        
//        videoFolders.remove(at: 0)
//        videoFolders.sort()
//        videoFolders.uniqued()
//        haldiNewThumbnail.uniqued()
//          print(videoFolders)
//
//        getMehandiThumbnails()
//        getHaldiThumbnails()
//        getPreweddingThumbnails()
//        getMuhuratThumbnails()
//        getSangeetThumbnails()
//        getReceptionThumbnails()
    }
    
    
    
    
}
extension VideoCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       // return backgroundFolder?.images.count ?? 0
        return eventvideos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCollection", for: indexPath) as! VideoCollectionCollectionViewCell
        
        if let backgroundImage = backgroundFolder?.images[indexPath.item] {
            
          //  print("array count", backgroundFolder?.images.count)
            //  print(thumbnailImage)
            DispatchQueue.global().async {
                if let data = try? Data( contentsOf: backgroundImage)
            {
              DispatchQueue.main.async {
                cell.videoImage.image = UIImage( data:data)
                  
                
              }
            }
         }
          
        }

        // cell.videoImage.image = bgVideoArray[indexPath.item]
         cell.videoImage.layer.borderWidth = 3
         cell.videoImage.layer.cornerRadius = 3
         cell.videoImage.layer.borderColor = UIColor.white.cgColor
         cell.videoImage.layer.masksToBounds = false
         cell.videoImage.clipsToBounds = true
         cell.videoadded = eventvideos[indexPath.item]
        cell.videoLabel.text = eventvideos[indexPath.item].vtitle
         cell.delegate = self
         //eventname =  videoFolders[indexPath.item]
         // print(eventname)
       

        return cell
    }
}

extension VideoCollectionViewController : UICollectionViewDelegate, VideosDelegate {
    func playButtonTapped(playVideo: URL) {
        //
    }
    
    func videoselectButtonTapped(videoSelected: Video) {
        let viewcontroller = EventVideoListViewController.instantiate(fromStoryboard: .Main)
        viewcontroller.labelName = videoSelected.vtitle
        viewcontroller.displayImage = self.backgroundImage
        viewcontroller.eventVideo = videoSelected
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    

        
    }





extension VideoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 270, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
        
    }
    
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
