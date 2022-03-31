//
//  SwipeImageViewController.swift
//  Photography-HOTC
//
//  Created by apple on 02/11/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

class SwipeImageViewController: UIViewController {
    
    
    
    @IBOutlet weak var swipeCollection: UICollectionView!
    
    @IBOutlet weak var labelName: UILabel!
    
    var headerLabel: String = ""
    var images: [UIImage] = []
    var selectedImage : UIImage?
    @IBAction func eventphotBackTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeScreen") as?  DisplayFolderViewController
        
        self.present(viewcontroller!, animated: true, completion: nil)
        
    }
    
    
    @IBAction func playTapped(_ sender: UIButton) {
        let viewcontroller1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toSlideshowPhoto") as?  SlideShowEPhotosViewController
        
         // viewcontroller1?.slidedImage = selectedImage
        viewcontroller1?.slidePhotos = images
        self.present(viewcontroller1!, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelName.text = headerLabel
        
    }
    
    
    
    
}
extension SwipeImageViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "swipeImage", for: indexPath) as? SwipeImageCollectionViewCell
        if indexPath.row == 0 {
            cell?.swipeImage.image = selectedImage
            
        }
        else {
        cell?.swipeImage.image = images[indexPath.row]
        cell?.swipeImage.contentMode = .scaleAspectFill
        
    }
        return cell!
        
    }
    
    
}
extension SwipeImageViewController: UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = swipeCollection.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
