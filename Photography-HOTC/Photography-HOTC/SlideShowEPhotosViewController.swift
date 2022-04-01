//
//  SlideShowEPhotosViewController.swift
//  HOTCC
//
//  Created by apple on 27/10/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

class SlideShowEPhotosViewController: UIViewController {
    
    var currentCellIndex = 0
    
    var eventName: String = ""
    let sectionInsets = UIEdgeInsets(
        top: 2.0,
        left: 2.0,
        bottom: 2.0,
        right:2.0)
    private var itemsPerRow: CGFloat = 1
    var slidePhotos : [UIImage] = []
    var scheduleTime = Timer()
    
   
    @IBOutlet weak var slideCollection: UICollectionView!
    
    
    @IBOutlet weak var displayLabel: UILabel!
   
    
   
    @IBAction func pauseTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        slideCollection.dataSource = self
        slideCollection.delegate = self
//        DispatchQueue.main.async {
            self.scheduleTime = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.slideToNextPhoto), userInfo: nil, repeats: true)
            
        //}
        
        
    }
    @objc func slideToNextPhoto() {
       
        if currentCellIndex < slidePhotos.count {
                 let index = IndexPath.init(item: currentCellIndex, section: 0)
                 self.slideCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                // pageView.currentPage = counter
            currentCellIndex += 1
            } else {
                currentCellIndex = 0
                 let index = IndexPath.init(item: currentCellIndex, section: 0)
                 self.slideCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
                  //pageView.currentPage = counter
                currentCellIndex = 1
              }
        
    }
    
    
    
}
extension SlideShowEPhotosViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slidePhotos.count
     
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "slideshow", for: indexPath) as? SlideShowPhotoCollectionViewCell
        print(slidePhotos)
        cell?.slideImage.image = slidePhotos[indexPath.item]
        cell?.slideImage.contentMode = .scaleAspectFill
        return cell ?? UICollectionViewCell()
    }
    
    
}

extension SlideShowEPhotosViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.size
        return CGSize(width: size.width, height: size.height)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
        
    }
}
