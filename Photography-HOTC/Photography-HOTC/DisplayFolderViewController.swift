//
//  DisplayFolderViewController.swift
//  Photography-HOTC
//
//  Created by apple on 27/10/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import Foundation




class DisplayFolderViewController: UIViewController{
    
    let fileManager:FileManager = FileManager.default
  
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
    var standardImg: String!
    
    var photoFolders:[String] = []
    var updatedFolder:[String] = []
    var BackgroundImage: String = ""
    var Haldibg:String = ""
    var pathFiles = [String]()
    var HaldiImages = [String]()
    var MehandiImages = [String]()
    var ReceptionImage = [String]()
    var PreweddingImages = [String]()
    var backgroundImages = [String]()
    var sangeetImages = [String]()
    var MuhuratImages = [String]()
    
    var HaldiImages1 = [String]()
    var MehandiImages1 = [String]()
    var ReceptionImage1 = [String]()
    var PreweddingImages1 = [String]()
    var backgroundImages1 = [String]()
    var sangeetImages1 = [String]()
    var MuhuratImages1 = [String]()
    
    let delayInSeconds = 0.0
    
    var url :URL?
    
    
    var photoImage = ""
    
    
    var HaldiArray = [UIImage]()
    var MehandiArray = [UIImage]()
    var MuhuratArray = [UIImage]()
    var PreweddinArray = [UIImage]()
    var ReceptionArray = [UIImage]()
    var SangeetArray = [UIImage]()
    var bgArray = [UIImage]()
    
    
    @IBAction func photoTapped(_ sender: Any) {
        let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toPhotoCollection") as?  PhotoCollectionViewController
        if self.backgroundImage != nil {
            viewcontroller?.BackgroundImage = self.backgroundImage
            viewcontroller?.fileName = self.fileName
            viewcontroller?.filenames = self.filenames.uniqued()
            viewcontroller?.HaldiArray = HaldiArray.uniqued()
            viewcontroller?.MehandiArray = MehandiArray.uniqued()
            viewcontroller?.MuhuratArray = MuhuratArray.uniqued()
            viewcontroller?.PreweddinArray = PreweddinArray.uniqued()
            viewcontroller?.ReceptionArray = ReceptionArray.uniqued()
            viewcontroller?.SangeetArray = SangeetArray.uniqued()
            viewcontroller?.updatedFolder = updatedFolder.uniqued()
            viewcontroller?.photoFolders = photoFolders.uniqued()
            
        }
        else {
            print("No background image to access")
        }
        viewcontroller?.photoImage = self.photosName
        self.present(viewcontroller!, animated: true, completion: nil)
        // navigationController!.pushViewController(viewcontroller!, animated: true)
    }
    
    @IBAction func videos_Tapped(_ sender: Any) {
        let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toVideoCollection") as?  VideoCollectionViewController
        viewcontroller?.videoImage = self.videosName
        viewcontroller?.fileName = self.fileName
        viewcontroller?.filenames = self.filenames.uniqued()
        if self.backgroundImage != nil {
            viewcontroller?.backgroundImage = self.backgroundImage
            
        }
        else{
            print("No background image to access")
        }
        self.present(viewcontroller!, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listFolders()
        
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

        
        self.updatedFolder.append(contentsOf: self.photoFolders)
        
        print(self.updatedFolder)
        
        
        
        
        
        
    }
    func listFolders() {
        let fileManager = FileManager.default
        var dirPaths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPaths[0]
        
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: docDir, includingPropertiesForKeys: nil, options: [])
            
            let subDirs = directoryContents.filter{ $0.hasDirectoryPath }
            let subDirsName = subDirs.map{ $0.lastPathComponent }
            print(subDirsName)
            let folderfilter = subDirsName.filter({ $0 != ".DS_Store" && $0 != ".Trash" })
            if !(folderfilter.isEmpty)  {
                
                getFolderNames()
                getBackgroundImage()
                self.getPhotsFolderNames()
                // self.getcollectionbackground()
                self.getHaldiImageFromDocumentDirectory()
                self.getWeddingImageFromDocumentDirectory()
                self.getReceptionImageFromDocumentDirectory()
                self.getMehandiImageFromDocumentDirectory()
                
                
                
                self.getSangeetImageFromDocumentDirectory()
                self.getPREweddingImageFromDocumentDirectory()
                self.photoFolders.remove(at: 0)
                
                self.updatedFolder.append(contentsOf: self.photoFolders)
                
                print(self.updatedFolder)
                
                
            }
            
            else {
                self.setLabel.text = "Bride & Bridegroom"
                self.photoFolder.isHidden = true
                self.videoFolder.isHidden = true
                self.imageVIew.image = UIImage(named: "Background")
            }
            
            
            
        } catch let error as NSError {
            
            print(error)
        }
    }
    
    
}
extension DisplayFolderViewController  {
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
            print(filenames)
            
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
    
    func getPhotsFolderNames() {
        for files in filenames {
            func contentsOfDirectoryAtPath(path: String) -> [String]? {
                
                guard let paths = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(files)/") else { return nil}
                print(paths)
                let folderFilter = paths.filter({ $0 != ".DS_Store" })
                photoFolders.append(contentsOf: folderFilter)
                photoFolders.sort()
                print("folders",photoFolders)
                return paths.map { aContent in (path as NSString).appendingPathComponent(aContent)}
            }
        }
        
        func contentsOfDirectoryAtPath(path: String) -> [String]? {
            
            guard let paths = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[1])/") else { return nil}
            print(paths)
            let folderFilter = paths.filter({ $0 != ".DS_Store" })
            photoFolders.append(contentsOf: folderFilter)
            photoFolders.sort()
            print("folders",photoFolders)
            
            //            guard let background = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/PHOTOS/BACKGROUND/") else { return nil}
            //            if background != nil {
            //                let bgImages = background.filter({ $0 != ".DS_Store" })
            //                backgroundImages.append(contentsOf: bgImages)
            //                backgroundImages.sort()
            //                //print(backgroundImages)
            //            }
            //            else {
            //                print("No events background uploaded")
            //            }
            
            guard let haldi = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[1])/\(photoFolders[0])/") else { return nil}
            if haldi != nil {
                let haldiFilter = haldi.filter({ $0 != ".DS_Store" })
                HaldiImages.append(contentsOf: haldiFilter)
                HaldiImages.sort()
                // print(HaldiImages)
            }
            else {
                print("No photos found in Haldi folder")
            }
            guard let mehandi = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[1])/\(photoFolders[1])/") else { return nil}
            if mehandi != nil {
                let mehandiFilter = mehandi.filter({ $0 != ".DS_Store" })
                MehandiImages.append(contentsOf: mehandiFilter)
                MehandiImages.sort()
                // print(MehandiImages)
            }
            else {
                print("No photos found in Mehandi folder")
            }
            guard let muhurat = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[1])/\(photoFolders[2])/") else { return nil}
            if muhurat != nil {
                let mahuratFilter = muhurat.filter({ $0 != ".DS_Store" })
                MuhuratImages.append(contentsOf: mahuratFilter)
                MuhuratImages.sort()
                // print(MuhuratImages)
            }
            else {
                print("No photos found in Wedding folder")
            }
            guard let prewedding = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[1])/\(photoFolders[3])/") else { return nil}
            if prewedding != nil {
                let preweddingFilter = prewedding.filter({ $0 != ".DS_Store" })
                PreweddingImages.append(contentsOf: preweddingFilter)
                PreweddingImages.sort()
                // print(PreweddingImages)
            }
            else {
                print("No photos found in prewedding folder")
            }
            
            guard let reception = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[1])/\(photoFolders[4])/") else { return nil}
            if reception != nil {
                let receptionFilter = reception.filter({ $0 != ".DS_Store" })
                ReceptionImage.append(contentsOf: receptionFilter)
                ReceptionImage.sort()
            }
            else {
                print("No photos found in reception folder")
            }
            
            
            
            guard let sangeet = try? FileManager.default.contentsOfDirectory(atPath: path + "/\(fileName!)/\(filenames[1])/\(photoFolders[5])/") else { return nil}
            if sangeet != nil {
                let sangeetFilter = sangeet.filter({ $0 != ".DS_Store" })
                sangeetImages.append(contentsOf: sangeetFilter)
                sangeetImages.sort()
                print(sangeetImages)
            }
            else {
                print("No photos found in Sangeet folder")
            }
            
            return paths.map { aContent in (path as NSString).appendingPathComponent(aContent)}
            
        }
        
        let searchPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        _ = contentsOfDirectoryAtPath(path: searchPath)
        //print(contents)
    }
    /*
     func getcollectionbackground(){
     func getDirectoryPath() -> String {
     let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/PHOTOS/BACKGROUND")
     
     return path
     
     }
     
     let fileManager = FileManager.default
     
     for i in backgroundImages {
     let imagePath = (getDirectoryPath() as NSString).appendingPathComponent(i)
     //print(imagePath)
     let urlString: String = imagePath
     if fileManager.fileExists(atPath: urlString) {
     let image = UIImage(contentsOfFile: urlString)
     DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) { [weak self] in
     self!.bgArray.append(image!)
     
     }
     
     } else {
     print("No Image")
     }
     }
     
     }
     */
    
    func getHaldiImageFromDocumentDirectory() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[1])/\(photoFolders[0])")
            
            return path
            
        }
        
        
        let fileManager = FileManager.default
        
        for i in HaldiImages {
            
            let imagePath = (getDirectoryPath() as NSString).appendingPathComponent(i)
            //print(imagePath)
            let urlString: String = imagePath
            if fileManager.fileExists(atPath: urlString) {
                let image = UIImage(contentsOfFile: urlString)
                DispatchQueue.main.async {
                    self.HaldiArray.append(image!)
                }
                
            } else {
                print("No Image")
            }
        }
    }
    
    func getMehandiImageFromDocumentDirectory() {
        
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[1])/\(photoFolders[1])")
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in MehandiImages {
            
            let imagePath1 = (getDirectoryPath() as NSString).appendingPathComponent(i)
            
            let urlString1: String = imagePath1
            if fileManager.fileExists(atPath: urlString1) {
                let image = UIImage(contentsOfFile: urlString1)
                DispatchQueue.main.async {
                    
                    self.MehandiArray.append(image!)
                }
            } else {
                print("No Image")
            }
        }
    }
    
    func getWeddingImageFromDocumentDirectory() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[1])/\(photoFolders[2])")
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in MuhuratImages {
            
            let imagePath = (getDirectoryPath() as NSString).appendingPathComponent(i)
            
            let urlString: String = imagePath
            if fileManager.fileExists(atPath: urlString) {
                let image = UIImage(contentsOfFile: urlString)
                DispatchQueue.main.async {
                    
                    self.MuhuratArray.append(image!)
                    //  print("wedding images are",imageArray1)
                }
            } else {
                print("No Image")
            }
        }
    }
    func getPREweddingImageFromDocumentDirectory() {
        
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[1])/\(photoFolders[3])")
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in PreweddingImages {
            
            let imagePath = (getDirectoryPath() as NSString).appendingPathComponent(i)
            
            let urlString: String = imagePath
            if fileManager.fileExists(atPath: urlString) {
                let image = UIImage(contentsOfFile: urlString)
                DispatchQueue.main.async {
                    
                    self.PreweddinArray.append(image!)
                }
            } else {
                print("No Image")
            }
        }
    }
    func getReceptionImageFromDocumentDirectory() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[1])/\(photoFolders[4])")
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in ReceptionImage {
            
            let imagePath = (getDirectoryPath() as NSString).appendingPathComponent(i)
            
            let urlString: String = imagePath
            if fileManager.fileExists(atPath: urlString) {
                let image = UIImage(contentsOfFile: urlString)
                DispatchQueue.main.async {
                    
                    self.ReceptionArray.append(image!)
                }
            } else {
                print("No Image")
            }
        }
    }
    
    
    
    
    
    func getSangeetImageFromDocumentDirectory() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(fileName!)/\(filenames[1])/\(photoFolders[5])")
            return path
            
        }
        
        let fileManager = FileManager.default
        
        for i in sangeetImages {
            
            let imagePath = (getDirectoryPath() as NSString).appendingPathComponent(i)
            
            let urlString: String = imagePath
            if fileManager.fileExists(atPath: urlString) {
                let image = UIImage(contentsOfFile: urlString)
                DispatchQueue.main.async {
                    
                    self.SangeetArray.append(image!)
                }
            } else {
                print("No Image")
            }
        }
        
        
        
        
        
        
    }
    
    
}
