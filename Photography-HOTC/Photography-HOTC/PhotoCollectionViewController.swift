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
    
    var fileName:String?
    var filenames : [String] = []
    
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
  
    @IBOutlet weak var backgroundImage: UIImageView!
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
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.displayFolderName.text = self.photoImage
            self.updatedFolder.uniqued()
            self.HaldiArray.uniqued()
            self.MehandiArray.uniqued()
            self.MuhuratArray.uniqued()
            self.ReceptionArray.uniqued()
            self.PreweddinArray.uniqued()
            self.SangeetArray.uniqued()
            
            self.backgroundImage.image = UIImage(contentsOfFile: self.BackgroundImage)
            self.backgroundImage.autoresizingMask =  [.flexibleTopMargin, .flexibleHeight, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleWidth]
            //self.imageVIew.contentMode = .scaleToFill
           // self.imageVIew.clipsToBounds = true
            self.backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
          
           // self.imageVIew.clipsToBounds = true

          
        }
        
    }
    
    
    
}
extension PhotoCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return updatedFolder.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollection", for: indexPath) as! PhotoCollectionCollectionViewCell
            switch indexPath.item {
            case 0 :
              
                cell.photoCollection.image = HaldiArray.first
            case 1:
               
                cell.photoCollection.image = MehandiArray.first
            case 2:
                
                cell.photoCollection.image = MuhuratArray.first
                
            case 3:
                
                cell.photoCollection.image = PreweddinArray.first
               
            case 4:
               
                cell.photoCollection.image = ReceptionArray.first
              
            case 5:
                
                cell.photoCollection.image = SangeetArray.first
             
            default:
                print("others")
          
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


extension PhotoCollectionViewController {
    
    
    

    /// remove single file from document dir
    /// - Parameter fileName: filename which you want to remove
    func removeSingleFileFromDocumentDir(fileName: String) {
        let documentDirectory = FileManage.documentsDirectory()
        removeFileFromDocumentDirectory(documentDirectory: documentDirectory, path: fileName)
    }

    /// remove file from document dir
    /// - Parameters:
    ///   - documentDirectory: document dir path
    ///   - path: path in string
    fileprivate func removeFileFromDocumentDirectory(documentDirectory: URL, path: String) {
        let fileManager = FileManager.default
        let deletePath = documentDirectory.appendingPathComponent(path)
        do {
            try fileManager.removeItem(at: deletePath)
        } catch {
            // Non-fatal: file probably doesn't exist
        }
    }
    /// remove all file from document dir
    /// - Parameter documentDirectory: document dir url
    fileprivate func removeFromDocumentDirectory(documentDirectory: URL)  {
        let fileManager = FileManager.default
        do {
            let fileUrls = try fileManager.contentsOfDirectory(atPath: documentDirectory.path)
            for path in fileUrls {
                removeFileFromDocumentDirectory(documentDirectory: documentDirectory, path: path)
            }
        } catch {
            print("Error while enumerating files \(documentDirectory.path): \(error.localizedDescription)")
        }
    }
}
    

