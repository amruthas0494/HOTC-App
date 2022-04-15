//
//  DisplayFolderViewController.swift
//  Photography-HOTC
//
//  Created by apple on 27/10/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import Foundation
struct Photo {
    let title: String
    let thumbnail: URL?
    let images: [URL]
}

struct Video {
    let vtitle: String
    let vthumbnail: [VideoThumbnails]
    let playlist: [PlayList]
    //    let thumbnails : [URL]
}
struct PlayList {
    // let videoThumbnail : URL?
    let videoURL : URL?
    
}
struct Background {
    let images: [URL]
    
}
struct VideoThumbnails {
    let thumbnails : [URL]
    
}

class DisplayFolderViewController: UIViewController{
    
    let fileManager:FileManager = FileManager.default
    var photos = [Photo]()
    var videos = [Video]()
    var backgroundFolder = [Background]()
    var videothumbnail  = [VideoThumbnails]()
    var eventvideoThumbnail :URL?
    
    @IBOutlet weak var imageVIew: UIImageView!
    
    
    @IBOutlet weak var setLabel: UILabel!
    
    @IBOutlet weak var photoFolder: UIButton!
    
    @IBOutlet weak var videoFolder: UIButton!
    
    var file:URL?
    var fileName:String?
    var filenames : [String] = []
    
    var backgroundImage : String!
    var photosName = ""
    var videosName = ""
    var ScreenBackground:String!
    var backgroundImg : [String] = []
    var standardImg: [URL] = []
    
    
    
    let delayInSeconds = 0.0
    
    var url :URL?
    var backgroundPhoto :URL?
    
    
    @IBAction func photoTapped(_ sender: Any) {
        let vc = PhotoCollectionViewController.instantiate(fromStoryboard: .Main)
        vc.BackgroundImage = self.backgroundImage
        vc.eventphotos = photos
        vc.fileName = fileName
        vc.filenames = filenames
        vc.photoImage = self.photosName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func videos_Tapped(_ sender: Any) {
        let vc = VideoCollectionViewController.instantiate(fromStoryboard: .Main)
        vc.backgroundImage = self.backgroundImage
        vc.fileName = fileName
        vc.filenames = filenames
        vc.videoImage = self.videosName
        vc.eventvideos = videos
        vc.backgroundFolder = backgroundFolder
        
        
        //        vc.eventphotos = photos
        //        vc.eventImage = standardImg
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.navigationBar.isHidden = true
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listFolders()
        for image in standardImg {
            if let data = try? Data(contentsOf: image)
            {
                let image: UIImage = UIImage(data: data)!
                self.imageVIew.image = image
                
            }
        }
        
        self.photoFolder.layer.borderWidth = 3
        self.photoFolder.layer.borderColor = UIColor.white.cgColor
        self.photoFolder.layer.masksToBounds = false
        self.photoFolder.clipsToBounds = true
        
        
        // createFileDirectory()
        
        self.videoFolder.layer.borderWidth = 3
        self.videoFolder.layer.borderColor = UIColor.white.cgColor
        self.videoFolder.layer.masksToBounds = false
        self.videoFolder.clipsToBounds = true
        //self.imageVIew.image = UIImage(named: backgroundImage!)
        
        
        
        
        
        
        
        
    }
    
    // For getting subdirectories of a giver URL
    // Eg:-  If you pass "SOBIA & ZOHAIB" directory, this will return you 'PHOTOS' & 'VIDEOS' directory (Full url of that)
    // If you pass 'PHOTOS'  directory, this will return you 'HALDI', 'MUHURTHAM', 'RECEPTION'...  etc directories
    func getSubDirectories(of directory: URL) -> [URL] {
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil, options: [])
            
            let subDirectories = directoryContents.filter{ $0.hasDirectoryPath }
            return subDirectories
        } catch {
            return []
        }
    }
    
    // For getting all files in a directory
    func getAllFiles(of directory: URL) -> [URL] {
        do {
            let files = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
            return files
        } catch {
            return []
        }
    }
    
    func listFolders() {
        let fileManager = FileManager.default
        let dirPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        if dirPath.isHavingFiles {
            if let eventDirectory = getSubDirectories(of: dirPath).first {
                var media = getSubDirectories(of: eventDirectory)
                if eventDirectory.isHavingFiles {
                    print("true")
                    getFolderNames()
                    let backgroundDir = media.filter { $0.directoryName == "BACKGROUND" ||  $0.directoryName == "Background"  }.first!
                    
                    // let backgroundDir = media.filter { $0.directoryName == filenames[0] }.first!
                    //var background = getSubDirectories(of: backgroundDir)
                    if backgroundDir.isHavingFiles {
                        getBackgroundImage()
                        //                    let backImage = getAllFiles(of: backgroundDir)
                        //                    for image in backImage{
                        //                    self.standardImg.append(image)
                        //                    print(standardImg)
                        //                    }
                    }
                    
                    else {
                        self.imageVIew.image = UIImage(named: "Background")
                    }
                    let photosDir = media.filter { $0.directoryName == "PHOTOS" ||  $0.directoryName == "Photos" }.first!
                    if photosDir.isHavingFiles {
                        print("true")
                        let photoTypeDir = getSubDirectories(of: photosDir)
                        for url in photoTypeDir {
                            let photoItem = Photo(title: url.directoryName.uppercased(), thumbnail:getAllFiles(of: url).first, images: getAllFiles(of: url))
                            // print(photoItem)
                            photos.append(photoItem)
                            //standardImg.append(contentsOf: photoItem.images)
                        }
                        // self.getPhotsFolderNames()
                        
                    }
                    else {
                        DispatchQueue.main.async {
                            self.photoFolder.isHidden = true
                        }
                    }
                    
                    
                    let videoDir = media.filter { $0.directoryName == "VIDEOS"  ||  $0.directoryName == "Videos" }.first!
                    if videoDir.isHavingFiles {
                        print("true")
                        var videoTypesDir = getSubDirectories(of: videoDir)
                        let background = videoTypesDir.filter { $0.directoryName == "BACKGROUND"  ||  $0.directoryName == "Background" }.first!
                        if background.isHavingFiles {
                            //print(background)
                            let backgroundItem = Background(images: getAllFiles(of: background))
                            print(backgroundItem)
                            backgroundFolder.append(backgroundItem)
                        }
                        else {
                            print("no images")
                        }
                        videoTypesDir.removeFirst()
                        print(videoTypesDir)
                        
                        for videoUrl in videoTypesDir {
                            let videosFiles = videoUrl.allFiles
                            let thumbNail = videosFiles.filter { $0.directoryName == "Thumbnails" }.first!
                            // print(thumbNail)
                            if thumbNail.isHavingFiles {
                                let thumbnailFiles = VideoThumbnails(thumbnails: getAllFiles(of: thumbNail))
                                print(thumbnailFiles)
                                videothumbnail.append(thumbnailFiles)
                                //
                                
                                
                            }
                            
                            for  video in videosFiles {
                                
                                print("video", video)
                                
                                let playlistItem = PlayList(videoURL: video)
                                
                            }
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            self.videoFolder.isHidden = true
                        }
                    }
                }
                else {
                    self.setLabel.text = "Bride & Bridegroom"
                }
                
                
                
                //                    let videoItem = vide
                //                    print(videoItem)
                //                    videos.append(videoItem)
                
                
            }
            //
            
        }
        
        else {
            self.setLabel.text = "Bride & Bridegroom"
            self.photoFolder.isHidden = true
            self.videoFolder.isHidden = true
        }
    }
    
    
}

extension DisplayFolderViewController  {
    func allFileListFromDocumentDir(whichExtension: String?) -> [URL]? {
        let fileManager = FileManager.default
        let documentDirectory = FileManage.documentsDirectory()
        do {
            let fileUrls = try fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil, options: [])
            if let pathExtension = whichExtension {
                let specificFiles = fileUrls.filter{ $0.pathExtension == pathExtension }
                return specificFiles
            } else {
                return fileUrls
            }
        } catch {
            print("Error while enumerating files \(documentDirectory.path): \(error.localizedDescription)")
            return nil
        }
    }
    func getFolderNames(){
        func contentsOfDirectoryAtPath(path: String) -> [String]? {
            guard let paths = try? FileManager.default.contentsOfDirectory(atPath: path) else { return nil}
            
            let folderfilter = paths.filter({ $0 != ".DS_Store" && $0 != ".Trash" })
            fileName = folderfilter[0]
            
            print("my file name \(fileName!)")
            guard let paths1 = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/") else { return nil}
            let pathFilter = paths1.filter({ $0 != ".DS_Store" })
            
            filenames.append(contentsOf: pathFilter)
            filenames.sort()
            // print(filenames)
            
            
            for files in self.filenames {
                
                DispatchQueue.main.async {
                    
                    self.setLabel.text = self.fileName!
                    
                    if files == self.filenames[1] {
                        self.photoFolder.setTitle(files, for: .normal)
                        self.photosName = files
                    }
                    
                    else if files == self.filenames[2] {
                        self.videoFolder.setTitle(files, for: .normal)
                        self.videosName = files
                    }
                }
                
            }
            
            guard let background = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[0])/") else { return nil}
            
            
            if background != nil {
                let backgroundFilter = background.filter({ $0 != ".DS_Store" })
                for i in backgroundFilter {
                    ScreenBackground = i
                    backgroundImg.append(ScreenBackground)
                    backgroundImg.sort()
                    
                }
            }
            else {
                print("No Background Image")
                
            }
            
            
            return paths.map { aContent in (path as NSString).appendingPathComponent(aContent)}
        }
        
        
        
        let searchPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        _ = contentsOfDirectoryAtPath(path: searchPath)
        // print(contents)
        
    }
    func getBackgroundImage(){
        
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[0])")
        let fileManager = FileManager.default
        for img in backgroundImg {
            let backgroundImage = (paths as NSString).appendingPathComponent(img)
            
            if fileManager.fileExists(atPath: backgroundImage){
                if backgroundImage != nil {
                    DispatchQueue.main.async {
                        self.imageVIew.image = UIImage(contentsOfFile: backgroundImage)
                        self.backgroundImage = backgroundImage
                    }
                }
                
            }else{
                print("No Background Image")
                DispatchQueue.main.async {
                    self.imageVIew.image = UIImage(named: "Background.jpg")
                }
            }
        }
    }
    
    
}

extension URL {
    var directoryName: String {
        return self.lastPathComponent
    }
    
    
    // For getting subdirectories of a giver URL
    // Eg:-  If you pass "SOBIA & ZOHAIB" directory, this will return you 'PHOTOS' & 'VIDEOS' directory (Full url of that)
    // If you pass 'PHOTOS'  directory, this will return you 'HALDI', 'MUHURTHAM', 'RECEPTION'...  etc directories
    var subDirectories: [URL] {
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: nil, options: [])
            
            let subDirectories = directoryContents.filter{ $0.hasDirectoryPath }
            return subDirectories
        } catch {
            return []
        }
    }
    
    // For getting all files in a directory
    var allFiles: [URL] {
        do {
            let files = try FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: nil)
            return files
        } catch {
            return []
        }
    }
    
    var isHavingFiles: Bool {
        if let enumerator = FileManager.default.enumerator(at: self, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {
            for case let fileURL as URL in enumerator {
                do {
                    let fileAttributes = try fileURL.resourceValues(forKeys:[.isRegularFileKey])
                    if fileAttributes.isRegularFile! {
                        return true
                    }
                } catch {
                    return false
                }
            }
        }
        return false
    }
}
