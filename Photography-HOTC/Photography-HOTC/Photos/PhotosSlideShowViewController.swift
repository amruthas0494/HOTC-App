//
//  PhotosSlideShowViewController.swift
//  Photography-HOTC
//
//  Created by Cognitiveclouds on 13/04/22.
//  Copyright © 2022 apple. All rights reserved.
//

import UIKit

class PhotosSlideShowViewController: UIViewController {

    var counter = 0
    var slideImages = [URL]()
    var Images = [UIImage]()
    var timer: Timer?
    let sectionInsets = UIEdgeInsets(
        top: 2.0,
        left: 2.0,
        bottom: 2.0,
        right:2.0)
    @IBOutlet weak var slideShowCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slideShowCollectionView.dataSource = self
        slideShowCollectionView.delegate = self
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
    }
    @objc func changeImage() {
        
        if counter < slideImages.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.slideShowCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            //         pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.slideShowCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            //pageView.currentPage = counter
            counter = 1
        }
        
    }
    
    @IBAction func PauseButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension PhotosSlideShowViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slideImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlideImage", for: indexPath) as? PhotosSLideShowCollectionViewCell
        let eventImage = slideImages[indexPath.item]
        
        // print(eventImage)
         
        let data = try? Data(contentsOf: eventImage)

     if let imageData = data {
         let imageAdded = UIImage(data: imageData)
         cell?.slideImage.image = imageAdded
         //swipImages.append(imageAdded!)
         Images.append(imageAdded!)
     }
        
        cell?.slideImage.contentMode = .scaleAspectFill
        
        
        return cell!
    }
    
    
}
extension PhotosSlideShowViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = slideShowCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
