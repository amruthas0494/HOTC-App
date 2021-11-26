//
//  PhotoCollectionViewController.swift
//  HOTCC
//
//  Created by apple on 26/10/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UIViewController {
    
    var eventname:String = ""
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
    
    
    
    
    var photoImage = ""
    
    
    var HaldiArray = [UIImage]()
    var MehandiArray = [UIImage]()
    var MuhuratArray = [UIImage]()
    var PreweddinArray = [UIImage]()
    var ReceptionArray = [UIImage]()
    var SangeetArray = [UIImage]()
    var bgArray = [UIImage]()
    
    
    @IBOutlet weak var displayFolderName: UILabel!
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var photoCollection: UICollectionView!
    let sectionInsets = UIEdgeInsets(
        top: 5.0,
        left: 2.0,
        bottom: 5.0,
        right:2.0)
    private var itemsPerRow: CGFloat = 1
    
    
    
    @IBAction func photobackTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func homebuttonTapped(_ sender: UIButton) {
        let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeScreen") as?  DisplayFolderViewController
        
        self.present(viewcontroller!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.displayFolderName.text = self.photoImage
            
            
            self.imageDisplay.image = UIImage(contentsOfFile: self.BackgroundImage)
            self.getPhotsFolderNames()
            self.getcollectionbackground()
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
        
    }
    
    
    
}
extension PhotoCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return updatedFolder.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollection", for: indexPath) as! PhotoCollectionCollectionViewCell
        if bgArray.count == updatedFolder.count {
            cell.photoCollection.image = bgArray[indexPath.item]
        }
        else if bgArray.count != updatedFolder.count {
            cell.photoCollection.image = UIImage(named: "Wedding.jpg")
        }
        cell.photoCollection.layer.borderWidth = 3
        cell.photoCollection.layer.cornerRadius = 3
        cell.photoCollection.layer.borderColor = UIColor.white.cgColor
        cell.photoCollection.layer.masksToBounds = false
        cell.photoCollection.clipsToBounds = true
        cell.photoLabel.text = updatedFolder[indexPath.item]
        eventname =  updatedFolder[indexPath.item]
        print(eventname)
        return cell
        
    }
    
    
}
extension PhotoCollectionViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toEventPhotos") as?  PhotoEventDisplayViewController
            viewcontroller?.labelName = updatedFolder[0]
            viewcontroller?.viewImages = HaldiArray
            
            self.present(viewcontroller!, animated: true, completion: nil)
        case 1:
            let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toEventPhotos") as?  PhotoEventDisplayViewController
            viewcontroller?.labelName = updatedFolder[1]
            viewcontroller?.viewImages = MehandiArray
            
            self.present(viewcontroller!, animated: true, completion: nil)
        case 2:
            let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toEventPhotos") as?  PhotoEventDisplayViewController
            viewcontroller?.labelName = updatedFolder[2]
            viewcontroller?.viewImages = MuhuratArray
            
            self.present(viewcontroller!, animated: true, completion: nil)
        case 3:
            let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toEventPhotos") as?  PhotoEventDisplayViewController
            viewcontroller?.labelName = updatedFolder[3]
            viewcontroller?.viewImages = PreweddinArray
            
            self.present(viewcontroller!, animated: true, completion: nil)
        case 4:
            let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toEventPhotos") as?  PhotoEventDisplayViewController
            viewcontroller?.labelName = updatedFolder[4]
            viewcontroller?.viewImages = ReceptionArray
            
            self.present(viewcontroller!, animated: true, completion: nil)
        case 5:
            let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toEventPhotos") as?  PhotoEventDisplayViewController
            viewcontroller?.labelName = updatedFolder[5]
            viewcontroller?.viewImages = SangeetArray
            
            self.present(viewcontroller!, animated: true, completion: nil)
        default:
            print("others")
        }
        
    }
}


extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 250, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    
}

extension PhotoCollectionViewController  {
    
    func getPhotsFolderNames() {
        
        func contentsOfDirectoryAtPath(path: String) -> [String]? {
            
            guard let paths = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/PHOTOS/") else { return nil}
            
            let folderFilter = paths.filter({ $0 != ".DS_Store" })
            photoFolders.append(contentsOf: folderFilter)
            photoFolders.sort()
            // print("folders",photoFolders)
            
            guard let background = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/PHOTOS/BACKGROUND/") else { return nil}
            if background != nil {
                let bgImages = background.filter({ $0 != ".DS_Store" })
                backgroundImages.append(contentsOf: bgImages)
                backgroundImages.sort()
                //print(backgroundImages)
            }
            else {
                print("No events background uploaded")
            }
            
            guard let haldi = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/PHOTOS/HALDI/") else { return nil}
            if haldi != nil {
                let haldiFilter = haldi.filter({ $0 != ".DS_Store" })
                HaldiImages.append(contentsOf: haldiFilter)
                HaldiImages.sort()
                // print(HaldiImages)
            }
            else {
                print("No photos found in Haldi folder")
            }
            guard let wedding = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/PHOTOS/MUHURTHAM/") else { return nil}
            if wedding != nil {
                let mahuratFilter = wedding.filter({ $0 != ".DS_Store" })
                MuhuratImages.append(contentsOf: mahuratFilter)
                MuhuratImages.sort()
                // print(MuhuratImages)
            }
            else {
                print("No photos found in Wedding folder")
            }
            guard let reception = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/PHOTOS/RECEPTION/") else { return nil}
            if reception != nil {
                let receptionFilter = reception.filter({ $0 != ".DS_Store" })
                ReceptionImage.append(contentsOf: receptionFilter)
                ReceptionImage.sort()
            }
            else {
                print("No photos found in reception folder")
            }
            
            
            guard let mehandi = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/PHOTOS/MEHANDI/") else { return nil}
            if mehandi != nil {
                let mehandiFilter = mehandi.filter({ $0 != ".DS_Store" })
                MehandiImages.append(contentsOf: mehandiFilter)
                MehandiImages.sort()
                // print(MehandiImages)
            }
            else {
                print("No photos found in Mehandi folder")
            }
            guard let sangeet = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/PHOTOS/SANGEET/") else { return nil}
            if sangeet != nil {
                let sangeetFilter = sangeet.filter({ $0 != ".DS_Store" })
                sangeetImages.append(contentsOf: sangeetFilter)
                sangeetImages.sort()
                //  print(sangeetImages)
            }
            else {
                print("No photos found in Sangeet folder")
            }
            guard let prewedding = try? FileManager.default.contentsOfDirectory(atPath: path + "/HOTC/SOBIA & ZOHAIB/PHOTOS/PREWEDDING/") else { return nil}
            if prewedding != nil {
                let preweddingFilter = prewedding.filter({ $0 != ".DS_Store" })
                PreweddingImages.append(contentsOf: preweddingFilter)
                PreweddingImages.sort()
                // print(PreweddingImages)
            }
            else {
                print("No photos found in prewedding folder")
            }
            return paths.map { aContent in (path as NSString).appendingPathComponent(aContent)}
            
        }
        
        let searchPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        _ = contentsOfDirectoryAtPath(path: searchPath)
        //print(contents)
    }
    
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
    
    
    func getHaldiImageFromDocumentDirectory() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/PHOTOS/HALDI")
            
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
    
    
    func getWeddingImageFromDocumentDirectory() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/PHOTOS/MUHURTHAM")
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
    func getReceptionImageFromDocumentDirectory() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/PHOTOS/RECEPTION")
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
    
    
    func getMehandiImageFromDocumentDirectory() {
        
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/PHOTOS/MEHANDI")
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
    
    
    
    func getSangeetImageFromDocumentDirectory() {
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/PHOTOS/SANGEET")
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
    
    func getPREweddingImageFromDocumentDirectory() {
        
        func getDirectoryPath() -> String {
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("HOTC/SOBIA & ZOHAIB/PHOTOS/PREWEDDING")
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
    
}
