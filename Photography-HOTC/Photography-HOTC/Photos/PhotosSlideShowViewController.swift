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
    var scheduleTime = Timer()
    let sectionInsets = UIEdgeInsets(
        top: 2.0,
        left: 2.0,
        bottom: 2.0,
        right:2.0)
   
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var slideShowCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideShowCollectionView.dataSource = self
        slideShowCollectionView.delegate = self
        self.scheduleTime = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.slideToNextPhoto), userInfo: nil, repeats: true)
       
        self.slideShowCollectionView.reloadData()
        
        
        pauseButton.layer.cornerRadius = pauseButton.frame.height/2
        pauseButton.clipsToBounds = true
        
       
        slideShowCollectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
   
       
        
    }
    
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        slideShowCollectionView.collectionViewLayout.invalidateLayout()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        slideShowCollectionView.collectionViewLayout = flowLayout
    }

    @objc func slideToNextPhoto() {
        
        if counter < slideImages.count  {
            self.slideShowCollectionView.scrollToItem(at: IndexPath(item: counter, section: 0), at: .centeredHorizontally, animated: true)
            counter += 1
           
            
        }
        else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.slideShowCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let swipe = slideImages[indexPath.item]
        DispatchQueue.global().async {
            if let data = try? Data( contentsOf: swipe)
            {
                DispatchQueue.main.async {
                    cell.userImageView.image = UIImage( data:data)?.asOriginal
                    cell.userImageView.contentMode = .scaleAspectFit
                   
                    
                }
            }
        }
        
      
  
        return cell
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
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
