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
    var backgroundImage: String = ""
    var updatedbackground = ""
    var videoImage = ""
    var eventname: String = ""
    var videoFolders:[String] = []
    var videoBackground:[String] = []
    var bgVideoArray : [UIImage] = []
    
    var fileName:String?
    var filenames : [String] = []
    
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
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func homeTapped(_ sender: UIButton) {
        let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeScreen") as?  DisplayFolderViewController
        
        self.present(viewcontroller!, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVideosFolderNames()
        getcollectionbackground()
        getHaldiVideos()
        getmuhuratVideos()
        getpreweddingVideo()
        getreceptionVideo()
        getMehandiVideo()
        getSangeetVideo()
        DispatchQueue.main.async {
            self.displayFolderName.text = self.videoImage
            self.imageView.image = UIImage(contentsOfFile: self.backgroundImage)
            self.imageView.autoresizingMask =  [.flexibleTopMargin, .flexibleHeight, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleWidth]
         
            self.imageView.contentMode = UIView.ContentMode.scaleAspectFill
        }
        
        
        videoFolders.remove(at: 0)
        videoFolders.sort()
        videoFolders.uniqued()
        haldiNewThumbnail.uniqued()
          print(videoFolders)
        
        getMehandiThumbnails()
        getHaldiThumbnails()
        getPreweddingThumbnails()
        getMuhuratThumbnails()
        getSangeetThumbnails()
        getReceptionThumbnails()
    }
    
    
    
    
}
extension VideoCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videoFolders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCollection", for: indexPath) as! VideoCollectionCollectionViewCell
        if bgVideoArray.count == videoFolders.count {
            print("array count", bgVideoArray.count)
            cell.videoImage.image = bgVideoArray[indexPath.item]
        }
        else if bgVideoArray.count != videoFolders.count {
            cell.videoImage.image = UIImage(named: "Wedding.jpg")
        }
       // cell.videoImage.image = bgVideoArray[indexPath.item]
        cell.videoImage.layer.borderWidth = 3
        cell.videoImage.layer.cornerRadius = 3
        cell.videoImage.layer.borderColor = UIColor.white.cgColor
        cell.videoImage.layer.masksToBounds = false
        cell.videoImage.clipsToBounds = true
        cell.videoLabel.text = videoFolders[indexPath.item]
        eventname =  videoFolders[indexPath.item]
        // print(eventname)
        return cell
        
    }
}

extension VideoCollectionViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        switch indexPath.item {
        case 0:
            let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toVideoList") as?  EventVideoListViewController
            viewcontroller?.displayImage = backgroundImage
            viewcontroller?.allThumbnails = haldiNewThumbnail
            viewcontroller?.sharedVideos = uniquehaldiFolder
            viewcontroller?.labelName = videoFolders[0]
            self.present(viewcontroller!, animated: true, completion: nil)
        case 1:
            let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toVideoList") as?  EventVideoListViewController
            viewcontroller?.displayImage = backgroundImage
            viewcontroller?.allThumbnails = mehandiNewThumbnail
            viewcontroller?.sharedVideos = uniquemehandiFolder.sorted()
            viewcontroller?.labelName = videoFolders[1]
            self.present(viewcontroller!, animated: true, completion: nil)
        case 2:
            let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toVideoList") as?  EventVideoListViewController
            viewcontroller?.displayImage = backgroundImage
            viewcontroller?.allThumbnails = MuhuratNewThumbnail
            viewcontroller?.sharedVideos = uniquemuhuratFolder.sorted()
            viewcontroller?.labelName = videoFolders[2]
            self.present(viewcontroller!, animated: true, completion: nil)
        case 3:
            let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toVideoList") as?  EventVideoListViewController
            viewcontroller?.displayImage = backgroundImage
            viewcontroller?.allThumbnails = preweddingNewThumbnail
            viewcontroller?.sharedVideos = uniquepreweddingFolder
            viewcontroller?.labelName = videoFolders[3]
            self.present(viewcontroller!, animated: true, completion: nil)
        case 4:
            let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toVideoList") as?  EventVideoListViewController
            viewcontroller?.displayImage = backgroundImage
            viewcontroller?.allThumbnails = receptionNewThumbail
            viewcontroller?.sharedVideos = uniquereceptionFolder
            viewcontroller?.labelName = videoFolders[4]
            self.present(viewcontroller!, animated: true, completion: nil)
        case 5:
            let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toVideoList") as?  EventVideoListViewController
            viewcontroller?.displayImage = backgroundImage
            viewcontroller?.allThumbnails = sangeetNewThumbnail
            viewcontroller?.sharedVideos = uniquesangeetFolder
            viewcontroller?.labelName =  videoFolders[5]
            self.present(viewcontroller!, animated: true, completion: nil)
        default:
            print("others")
        }
        
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
extension VideoCollectionViewController  {
    
    func getVideosFolderNames(){
        
        func contentsOfDirectoryAtPath(path: String) -> [String]? {
            
            
            guard let videofolder = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[2])/") else { return nil}
            
            let array = videofolder.filter({ $0 != ".DS_Store" })
            // print("new folder array",array)
            videoFolders.append(contentsOf: array)
            videoFolders.sort()
            print(videoFolders)
            guard let bgfolder = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[2])/\(videoFolders[0])/") else { return nil}
            if  bgfolder != nil {
                let newarray = bgfolder.filter({ $0 != ".DS_Store" })
                videoBackground.append(contentsOf: newarray)
                videoBackground.sort()
            }
            else {
                print("No events found")
            }
            
           
            guard let haldivideo = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[2])/\(videoFolders[1])/") else { return nil}
           
            if haldivideo != nil {
                let haldi = haldivideo.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
               // let haldi = haldivideo.filter({ $0 != ".DS_Store"  })
                
                haldiVideos.append(contentsOf: haldi)
                haldiVideos.sort()
                print(haldiVideos)
            
            }
            else {
                print("No videos found in Haldi folder")
            }
            guard let hthumb = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[2])/\(videoFolders[1])/Thumbnails/") else { return nil}
            if hthumb != nil {
                let hthumbnail = hthumb.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
                haldiThumbnail.append(contentsOf: hthumbnail)
                haldiThumbnail.sort()
                print(haldiThumbnail)
            }
            else {
                print("No thumbnails found in Haldi thumbnails folder")
            }
            guard let mehandivideo = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[2])/\(videoFolders[2])/") else { return nil}
            if mehandivideo != nil {
                let mehandi = mehandivideo.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
                mehandiVideos.append(contentsOf: mehandi)
                mehandiVideos.sort()
            }
            else {
                print("No videos found in mehandi folder")
            }
            guard let mthumb = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[2])/\(videoFolders[2])/Thumbnails/") else { return nil}
            if mthumb != nil {
                let mthumbnail = mthumb.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
                mehandiThumbnail.append(contentsOf: mthumbnail)
                mehandiThumbnail.sort()
            }
            else {
                print("No thumbnails found in Mehandi thumbnails folder")
            }
            
            guard let muhuratvideo = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[2])/\(videoFolders[3])/") else { return nil}
            if muhuratvideo != nil {
                let muhurat = muhuratvideo.filter({ $0 != ".DS_Store" && $0 != "Thumbnails"})
                muhuratVideos.append(contentsOf: muhurat)
                muhuratVideos.sort()
            }
            else {
                print("No videos found in Muhurat folder")
            }
            guard let mtthumb = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[2])/\(videoFolders[3])/Thumbnails/") else { return nil}
            if mtthumb != nil {
                let mtthumbnail = mtthumb.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
                MuhuratThumbnail.append(contentsOf: mtthumbnail)
                MuhuratThumbnail.sort()
            }
            else {
                print("No thumbnails found in Muhurat thumbnails folder")
            }
            
            
            guard let preweddingvideo = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[2])/\(videoFolders[4])/") else { return nil}
            if preweddingvideo != nil {
                let prewedding = preweddingvideo.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
                preweddingVideos.append(contentsOf: prewedding)
                preweddingVideos.sort()
            }
            else {
                print("No videos found in prewedding folder")
            }
            guard let pthumb = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[2])/\(videoFolders[4])/Thumbnails/") else { return nil}
            if pthumb != nil {
                let pthumbnail = pthumb.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
                preweddingThumbnail.append(contentsOf: pthumbnail)
                preweddingThumbnail.sort()
            }
            else {
                print("No thumbnails found in prewedding thumbnails folder")
            }
            guard let receptionvideo = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[2])/\(videoFolders[5])/") else { return nil}
            if receptionvideo != nil {
                let reception = receptionvideo.filter({$0 != ".DS_Store" && $0 != "Thumbnails" })
                receptionVideos.append(contentsOf: reception)
                receptionVideos.sort()
            }
            else {
                print("No videos found in reception folder")
            }
            guard let rthumb = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[2])/\(videoFolders[5])/Thumbnails/") else { return nil}
            if rthumb != nil {
                let rthumbnail = rthumb.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
                receptionThumbail.append(contentsOf: rthumbnail)
                receptionThumbail.sort()
            }
            else {
                print("No thumbnails found in Reception thumbnails folder")
            }
            
           
            
            guard let sangeetvideo = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[2])/\(videoFolders[6])/") else { return nil}
            if sangeetvideo != nil {
                let sangeet = sangeetvideo.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
                sangeetVideos.append(contentsOf: sangeet)
                sangeetVideos.sort()
            }
            else {
                print("No videos found in sangeet folder")
            }
            
            guard let sthumb = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[2])/\(videoFolders[6])/Thumbnails/") else { return nil}
            if sthumb != nil {
                let sthumbnail = sthumb.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
                sangeetThumbnail.append(contentsOf: sthumbnail)
                sangeetThumbnail.sorted()
            }
            else {
                print("No thumbnails found in Sangeet thumbnails folder")
            }
            
            return videofolder.map { aContent in (path as NSString).appendingPathComponent(aContent)}
            
        }
        
        let searchPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        _ = contentsOfDirectoryAtPath(path: searchPath)
        //print(contents)
    }
    
    func getcollectionbackground(){
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[2])/\(videoFolders[0])")
            
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in videoBackground {
            
            let imagePath = (getDirectoryPath() as NSString).appendingPathComponent(i)
            
            let urlString: String = imagePath
            if fileManager.fileExists(atPath: urlString) {
                let image = UIImage(contentsOfFile: urlString)
                
                bgVideoArray.append(image!)
                
                
            } else {
                print("No Image")
            }
        }
        
    }
    
    
    
    func getHaldiVideos() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[2])/\(videoFolders[1])")
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in haldiVideos {
            
            let video = (getDirectoryPath() as NSString).appendingPathComponent(i)
            let urlString: String = video
            if fileManager.fileExists(atPath: urlString) {
                DispatchQueue.main.async {
                    self.updatedhaldivideos.append(urlString)
                    
                    self.uniquehaldiFolder = self.updatedhaldivideos.uniqued()
                    
                }
                
            } else {
                print("No Videos available")
            }
            
            
        }
    }
    
    func getMehandiVideo() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[2])/\(videoFolders[2])")
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in mehandiVideos {
            
            let video = (getDirectoryPath() as NSString).appendingPathComponent(i)
            let urlString: String = video
            if fileManager.fileExists(atPath: urlString) {
                
                updatedmehandivideos.append(urlString)
                
                uniquemehandiFolder = updatedmehandivideos.uniqued()
                uniquemehandiFolder.sort()
                // print("new mehandivideos",uniquemehandiFolder)
            } else {
                print("No Videos available")
            }
            
            
        }
        
        
    }
    
    func getmuhuratVideos() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[2])/\(videoFolders[3])")
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in muhuratVideos {
            
            let video = (getDirectoryPath() as NSString).appendingPathComponent(i)
            let urlString: String = video
            if fileManager.fileExists(atPath: urlString) {
                DispatchQueue.main.async {
                    self.updatedmuhuratvideos.append(urlString)
                    
                    self.uniquemuhuratFolder = self.updatedmuhuratvideos.uniqued()
                    
                }
                
            } else {
                print("No Videos available")
            }
            
            
        }
    }
    
    func getpreweddingVideo() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[2])/\(videoFolders[4])")
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in preweddingVideos {
            
            let video = (getDirectoryPath() as NSString).appendingPathComponent(i)
            let urlString: String = video
            if fileManager.fileExists(atPath: urlString) {
                
                updatedpreweddingvideos.append(urlString)
                
                uniquepreweddingFolder = updatedpreweddingvideos.uniqued()
                
            } else {
                print("No Videos availablee")
            }
            
            
        }
    }
    func getreceptionVideo() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[2])/\(videoFolders[5])")
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in receptionVideos {
            
            let video = (getDirectoryPath() as NSString).appendingPathComponent(i)
            let urlString: String = video
            if fileManager.fileExists(atPath: urlString) {
                
                updatedreceptionvideos.append(urlString)
                
                uniquereceptionFolder = updatedreceptionvideos.uniqued()
                
            } else {
                print("No Videos available")
            }
            
            
        }
    }
    
   
    func getSangeetVideo() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[2])/\(videoFolders[6])")
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in sangeetVideos {
            
            let video = (getDirectoryPath() as NSString).appendingPathComponent(i)
            let urlString: String = video
            if fileManager.fileExists(atPath: urlString) {
                
                updatedsangeetvideos.append(urlString)
                
                uniquesangeetFolder = updatedsangeetvideos.uniqued()
                //print("new videos",uniquesangeetFolder)
            } else {
                print("No Videos available")
            }
            
            
        }
    }
    
    
    
    func getHaldiThumbnails() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[2])/\(videoFolders[0])/Thumbnails")
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in haldiThumbnail {
            
            
            let imagePath = (getDirectoryPath() as NSString).appendingPathComponent(i)
            //print(imagePath)
            let urlString: String = imagePath
            if fileManager.fileExists(atPath: urlString) {
                let image = UIImage(contentsOfFile: urlString)
                DispatchQueue.main.async {
                    
                    self.haldiNewThumbnail.append(image!)
                    self.haldiNewThumbnail.uniqued()
                }
            } else {
                print("No haldi thumbnails ")
            }
        }
        
    }
    func getMehandiThumbnails() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[2])/\(videoFolders[1])/Thumbnails")
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in mehandiThumbnail {
            
            
            let imagePath = (getDirectoryPath() as NSString).appendingPathComponent(i)
            
            let urlString: String = imagePath
            if fileManager.fileExists(atPath: urlString) {
                let image = UIImage(contentsOfFile: urlString)
                DispatchQueue.main.async {
                    
                    self.mehandiNewThumbnail.append(image!)
                    self.mehandiNewThumbnail.uniqued()
                }
            } else {
                print("No mehandi thumbnails ")
            }
        }
        
    }
    func getMuhuratThumbnails() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[2])/\(videoFolders[2])/Thumbnails")
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in MuhuratThumbnail {
            
            
            let imagePath = (getDirectoryPath() as NSString).appendingPathComponent(i)
            
            let urlString: String = imagePath
            if fileManager.fileExists(atPath: urlString) {
                let image = UIImage(contentsOfFile: urlString)
                DispatchQueue.main.async {
                    
                    self.MuhuratNewThumbnail.append(image!)
                    self.MuhuratNewThumbnail.uniqued()
                }
            } else {
                print("No muhurat thumbnails ")
            }
        }
        
    }
    func getPreweddingThumbnails() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[2])/\(videoFolders[3])/Thumbnails")
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in preweddingThumbnail {
            
            
            let imagePath = (getDirectoryPath() as NSString).appendingPathComponent(i)
            //print(imagePath)
            let urlString: String = imagePath
            if fileManager.fileExists(atPath: urlString) {
                let image = UIImage(contentsOfFile: urlString)
                DispatchQueue.main.async {
                    
                    self.preweddingNewThumbnail.append(image!)
                    self.preweddingNewThumbnail.uniqued()
                }
            } else {
                print("No prewedding thumbnails ")
            }
        }
        
    }
    
    func getReceptionThumbnails() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[2])/\(videoFolders[4])/Thumbnails")
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in receptionThumbail {
            
            
            let imagePath = (getDirectoryPath() as NSString).appendingPathComponent(i)
            //print(imagePath)
            let urlString: String = imagePath
            if fileManager.fileExists(atPath: urlString) {
                let image = UIImage(contentsOfFile: urlString)
                DispatchQueue.main.async {
                    
                    self.receptionNewThumbail.append(image!)
                    self.receptionNewThumbail.uniqued()
                }
            } else {
                print("No reception thumbnails ")
            }
        }
        
    }
    func getSangeetThumbnails() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[2])/\(videoFolders[5])/Thumbnails")
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in sangeetThumbnail {
            
            
            let imagePath = (getDirectoryPath() as NSString).appendingPathComponent(i)
            
            let urlString: String = imagePath
            if fileManager.fileExists(atPath: urlString) {
                let image = UIImage(contentsOfFile: urlString)
                DispatchQueue.main.async {
                    
                    self.sangeetNewThumbnail.append(image!)
                    self.sangeetNewThumbnail.uniqued()
                    
                }
            } else {
                print("No sangeet thumbnails ")
            }
        }
        
    }
    
}
extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
