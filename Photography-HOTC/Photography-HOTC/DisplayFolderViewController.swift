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
    var filenames : [String] = []
    var fileName:String?
    var backgroundImage : String!
    var photosName = ""
    var videosName = ""
    var ScreenBackground:String!
     var backgroundImg : [String] = []
    var standardImg: String!
    
    
    @IBAction func photoTapped(_ sender: Any) {
        let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toPhotoCollection") as?  PhotoCollectionViewController
        if self.backgroundImage != nil {
        viewcontroller?.BackgroundImage = self.backgroundImage
       
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
        if self.backgroundImage != nil {
              viewcontroller?.backgroundImage = self.backgroundImage
             
              }
        else{
             print("No background image to access")
        }
        self.present(viewcontroller!, animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getFolderNames()
        getBackgroundImage()
        
        DispatchQueue.main.async {
            self.setLabel.text = self.fileName!
            
            for files in self.filenames {
                if files == "PHOTOS" {
                    
                    self.photoFolder.setTitle(files, for: .normal)
                    self.photosName = files
                    
                }
                else if files == "VIDEOS" {
                    self.videoFolder.setTitle(files, for: .normal)
                    self.videosName = files
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
        
        
        
    }
    
    
}
extension DisplayFolderViewController  {
    func getFolderNames(){
        func contentsOfDirectoryAtPath(path: String) -> [String]? {
            guard let paths = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/") else { return nil}
            
            let folderfilter = paths.filter({ $0 != ".DS_Store" })
            fileName = folderfilter[0]
            //  print("my file name \(fileName!)")
            guard let paths1 = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/") else { return nil}
            let pathFilter = paths1.filter({ $0 != ".DS_Store" })
            
            filenames.append(contentsOf: pathFilter)
            filenames.sort()
            print(filenames)
            guard let background = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/BACKGROUND/") else { return nil}
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
        
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/BACKGROUND")
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

