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
    var scheduleTime : Timer?
    
   
    @IBOutlet weak var imageSlideCollection: UICollectionView!
    
    @IBOutlet weak var displayLabel: UILabel!
   
    
    @IBAction func pauseTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        imageSlideCollection.dataSource = self
        imageSlideCollection.delegate = self
        
        scheduleTime = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(slideToNextPhoto), userInfo: nil, repeats: true)
    }
    @objc func slideToNextPhoto() {
        
        if currentCellIndex < slidePhotos.count - 1 {
            currentCellIndex += 1
            
        }
        else {
            currentCellIndex = 0
        }
        imageSlideCollection.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }
    
    
    
}
extension SlideShowEPhotosViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slidePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "slideshow", for: indexPath) as? SlideShowPhotoCollectionViewCell
        cell?.imageSlide.image = slidePhotos[indexPath.item]
        cell?.imageSlide.contentMode = .scaleAspectFill
        return cell ?? UICollectionViewCell()
    }
    
    
}

extension SlideShowEPhotosViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 768, height: 1024)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
        
    }
}
