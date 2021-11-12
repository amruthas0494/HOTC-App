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
        }
        
        
        videoFolders.remove(at: 0)
        videoFolders.sort()
        //  print(videoFolders)
        
        getMehandiThumbnails()
        getHaldiThumbnails()
        getPreweddingThumbnails()
        getMuhuratThumbnails()
        getSangeetThumbnails()
        getReceptionThumbnails()
    }
    
    
    
    
}
extension VideoCollectionViewController: UICollectionViewDataSource {
    //    func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        return videoFolders.count - 1
    //    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videoFolders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCollection", for: indexPath) as! VideoCollectionCollectionViewCell
        cell.videoImage.image = bgVideoArray[indexPath.item]
        cell.videoImage.layer.borderWidth = 3
        cell.videoImage.layer.cornerRadius = 3
        cell.videoImage.layer.borderColor = UIColor.white.cgColor
        cell.videoImage.layer.masksToBounds = false
        cell.videoImage.clipsToBounds = true
        cell.videoLabel.text = videoFolders[indexPath.item]
        eventname =  videoFolders[indexPath.item]
        // print(eventname)
        return cell
        /* switch indexPath.section {
         case 0:
         cell.videoImage.image = bgVideoArray[3]
         cell.videoImage.layer.borderWidth = 3
         cell.videoImage.layer.cornerRadius = 3
         cell.videoImage.layer.borderColor = UIColor.white.cgColor
         cell.videoImage.layer.masksToBounds = false
         cell.videoImage.clipsToBounds = true
         cell.videoLabel.text = videoFolders[1]
         eventname =  videoFolders[1]
         print(eventname)
         return cell
         case 1:
         cell.videoImage.image = bgVideoArray[4]
         cell.videoImage.layer.borderWidth = 3
         cell.videoImage.layer.cornerRadius = 3
         cell.videoImage.layer.borderColor = UIColor.white.cgColor
         cell.videoImage.layer.masksToBounds = false
         cell.videoImage.clipsToBounds = true
         cell.videoLabel.text = videoFolders[2]
         eventname =  videoFolders[2]
         print(eventname)
         return cell
         case 2:
         cell.videoImage.image = bgVideoArray[0]
         cell.videoImage.layer.borderWidth = 3
         cell.videoImage.layer.cornerRadius = 3
         cell.videoImage.layer.borderColor = UIColor.white.cgColor
         cell.videoImage.layer.masksToBounds = false
         cell.videoImage.clipsToBounds = true
         cell.videoLabel.text = videoFolders[3]
         eventname =  videoFolders[3]
         print(eventname)
         return cell
         case 3:
         cell.videoImage.image = bgVideoArray[1]
         cell.videoImage.layer.borderWidth = 3
         cell.videoImage.layer.cornerRadius = 3
         cell.videoImage.layer.borderColor = UIColor.white.cgColor
         cell.videoImage.layer.masksToBounds = false
         cell.videoImage.clipsToBounds = true
         cell.videoLabel.text = videoFolders[4]
         eventname =  videoFolders[4]
         print(eventname)
         return cell
         case 4:
         cell.videoImage.image = bgVideoArray[5]
         cell.videoImage.layer.borderWidth = 3
         cell.videoImage.layer.cornerRadius = 3
         cell.videoImage.layer.borderColor = UIColor.white.cgColor
         cell.videoImage.layer.masksToBounds = false
         cell.videoImage.clipsToBounds = true
         cell.videoLabel.text = videoFolders[5]
         eventname =  videoFolders[5]
         print(eventname)
         return cell
         case 5:
         cell.videoImage.image = bgVideoArray[2]
         cell.videoImage.layer.borderWidth = 3
         cell.videoImage.layer.cornerRadius = 3
         cell.videoImage.layer.borderColor = UIColor.white.cgColor
         cell.videoImage.layer.masksToBounds = false
         cell.videoImage.clipsToBounds = true
         cell.videoLabel.text = videoFolders[6]
         eventname =  videoFolders[6]
         print(eventname)
         return cell
         
         default:
         print("others")
         }
         return UICollectionViewCell()
         */
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
            viewcontroller?.sharedVideos = uniquemehandiFolder
            viewcontroller?.labelName = videoFolders[1]
            self.present(viewcontroller!, animated: true, completion: nil)
        case 2:
            let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toVideoList") as?  EventVideoListViewController
            viewcontroller?.displayImage = backgroundImage
            viewcontroller?.allThumbnails = MuhuratNewThumbnail
            viewcontroller?.sharedVideos = uniquemuhuratFolder
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
            
            
            guard let videofolder = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/VIDEOS/") else { return nil}
            
            let array = videofolder.filter({ $0 != ".DS_Store" })
            // print("new folder array",array)
            videoFolders.append(contentsOf: array)
            videoFolders.sort()
            //print(videoFolders)
            guard let bgfolder = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/VIDEOS/BACKGROUND/") else { return nil}
            let newarray = bgfolder.filter({ $0 != ".DS_Store" })
            videoBackground.append(contentsOf: newarray)
            videoBackground.sort()
            
            
            guard let haldivideo = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/VIDEOS/HALDI/") else { return nil}
            let haldi = haldivideo.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
            haldiVideos.append(contentsOf: haldi)
            haldiVideos.sort()
            
            guard let hthumb = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/VIDEOS/HALDI/Thumbnails/") else { return nil}
            let hthumbnail = hthumb.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
            haldiThumbnail.append(contentsOf: hthumbnail)
            haldiThumbnail.sort()
            
            guard let muhuratvideo = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/VIDEOS/MUHURTHAM/") else { return nil}
            let muhurat = muhuratvideo.filter({ $0 != ".DS_Store" && $0 != "Thumbnails"})
            muhuratVideos.append(contentsOf: muhurat)
            muhuratVideos.sort()
            
            guard let mtthumb = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/VIDEOS/MUHURTHAM/Thumbnails/") else { return nil}
            let mtthumbnail = mtthumb.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
            MuhuratThumbnail.append(contentsOf: mtthumbnail)
            MuhuratThumbnail.sort()
            
            
            
            guard let preweddingvideo = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/VIDEOS/PREWEDDING SHOOT/") else { return nil}
            let prewedding = preweddingvideo.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
            preweddingVideos.append(contentsOf: prewedding)
            preweddingVideos.sort()
            
            guard let pthumb = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/VIDEOS/PREWEDDING SHOOT/Thumbnails/") else { return nil}
            let pthumbnail = pthumb.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
            preweddingThumbnail.append(contentsOf: pthumbnail)
            preweddingThumbnail.sort()
            
            guard let receptionvideo = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/VIDEOS/RECEPTION/") else { return nil}
            let reception = receptionvideo.filter({$0 != ".DS_Store" && $0 != "Thumbnails" })
            receptionVideos.append(contentsOf: reception)
            receptionVideos.sort()
            
            guard let rthumb = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/VIDEOS/RECEPTION/Thumbnails/") else { return nil}
            let rthumbnail = rthumb.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
            receptionThumbail.append(contentsOf: rthumbnail)
            receptionThumbail.sort()
            
            
            guard let mehandivideo = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/VIDEOS/MEHANDI/") else { return nil}
            let mehandi = mehandivideo.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
            mehandiVideos.append(contentsOf: mehandi)
            mehandiVideos.sort()
            
            guard let mthumb = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/VIDEOS/MEHANDI/Thumbnails/") else { return nil}
            let mthumbnail = mthumb.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
            mehandiThumbnail.append(contentsOf: mthumbnail)
            mehandiThumbnail.sort()
            
            
            
            guard let sangeetvideo = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/VIDEOS/SANGEET/") else { return nil}
            let sangeet = sangeetvideo.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
            sangeetVideos.append(contentsOf: sangeet)
            sangeetVideos.sort()
            
            
            guard let sthumb = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/VIDEOS/SANGEET/Thumbnails/") else { return nil}
            let sthumbnail = sthumb.filter({ $0 != ".DS_Store" && $0 != "Thumbnails" })
            sangeetThumbnail.append(contentsOf: sthumbnail)
            sangeetThumbnail.sort()
            
            
            return videofolder.map { aContent in (path as NSString).appendingPathComponent(aContent)}
            
        }
        
        let searchPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        _ = contentsOfDirectoryAtPath(path: searchPath)
        //print(contents)
    }
    
    func getcollectionbackground(){
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/VIDEOS/BACKGROUND")
            
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
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/VIDEOS/HALDI")
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
    
    
    func getmuhuratVideos() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/VIDEOS/MUHURTHAM")
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
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/VIDEOS/PREWEDDING SHOOT")
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
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/VIDEOS/RECEPTION")
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
    
    func getMehandiVideo() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/VIDEOS/MEHANDI")
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
    func getSangeetVideo() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/VIDEOS/SANGEET")
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
    func getMehandiThumbnails() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/VIDEOS/MEHANDI/Thumbnails")
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
                    
                }
            } else {
                print("No mehandi thumbnails ")
            }
        }
        
    }
    func getHaldiThumbnails() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/VIDEOS/HALDI/Thumbnails")
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
                    
                }
            } else {
                print("No haldi thumbnails ")
            }
        }
        
    }
    
    func getMuhuratThumbnails() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/VIDEOS/MUHURTHAM/Thumbnails")
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
                    
                }
            } else {
                print("No muhurat thumbnails ")
            }
        }
        
    }
    func getPreweddingThumbnails() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/VIDEOS/PREWEDDING SHOOT/Thumbnails")
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
                }
            } else {
                print("No prewedding thumbnails ")
            }
        }
        
    }
    
    func getReceptionThumbnails() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/VIDEOS/RECEPTION/Thumbnails")
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
                    
                }
            } else {
                print("No reception thumbnails ")
            }
        }
        
    }
    func getSangeetThumbnails() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/VIDEOS/SANGEET/Thumbnails")
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
