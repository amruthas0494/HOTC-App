//
//  PhotoCollectionViewController.swift
//  HOTCC
//
//  Created by apple on 26/10/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UIViewController {
    
    var eventphotos = [Photo]()
    var eventImage = [URL]()
    
    var eventname:String = ""
    var IMAGES:[UIImage] = []
    var Array = [URL]()
    
    var Eventtitle:[String] = []
    
    var BackgroundImage: String = ""

    
    var fileName:String?
    var filenames : [String] = []
    
    var photoImage = ""
    let delayInSeconds = 0.0
    
    
    
  
    
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
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homebuttonTapped(_ sender: UIButton) {
        let vc = DisplayFolderViewController.instantiate(fromStoryboard: .Main)
       
        self.navigationController?.pushViewController(vc, animated: true)
        
     
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      // print(eventphotos)
        
        DispatchQueue.main.async {
            self.displayFolderName.text = self.photoImage
            
            self.backgroundImage.image = UIImage(contentsOfFile: self.BackgroundImage)
            self.backgroundImage.autoresizingMask =  [.flexibleTopMargin, .flexibleHeight, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleWidth]
            //self.imageVIew.contentMode = .scaleToFill
           // self.imageVIew.clipsToBounds = true
            self.backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
         

          
        }
        
    }
    
    
    
}
extension PhotoCollectionViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventphotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollection", for: indexPath) as! PhotoCollectionCollectionViewCell
      
            let thumbnailImage = eventphotos[indexPath.item].thumbnail

           //  print(thumbnailImage)
        DispatchQueue.global().async {
            if let data = try? Data( contentsOf: thumbnailImage!)
        {
          DispatchQueue.main.async {
            cell.photoCollection.image = UIImage( data:data)
          }
        }
     }
             
            cell.photoCollection.layer.borderWidth = 3
            cell.photoCollection.layer.cornerRadius = 3
            cell.photoCollection.layer.borderColor = UIColor.white.cgColor
            cell.photoCollection.layer.masksToBounds = false
            cell.photoCollection.clipsToBounds = true
            cell.photoLabel.text = eventphotos[indexPath.item].title
            
            
            eventname =  cell.photoLabel.text!
       // IMAGES =  eventphotos[indexPath.item].images
           // Eventtitle = e
//            print(eventname)
//        print(IMAGES)
//
       
       
   
       
        return cell
        
    }
    
    
}
extension PhotoCollectionViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")

        let currentCell = collectionView.cellForItem(at: indexPath)! as! PhotoCollectionCollectionViewCell
        eventname = currentCell.photoLabel.text!
        let vc = PhotoEventDisplayViewController.instantiate(fromStoryboard: .Main)
        vc.labelName = eventname
       // vc.swipImages = IMAGES
        vc.viewImages = eventphotos[indexPath.item].images
        self.navigationController?.pushViewController(vc, animated: true)
        
        
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


