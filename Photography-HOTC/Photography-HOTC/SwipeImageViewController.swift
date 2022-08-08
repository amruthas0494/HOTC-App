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
    
    @IBOutlet weak var playbutton: UIButton!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var labelName: UILabel!
    var imagesTOBeSlided = [UIImage]()
    var headerLabel: String = ""
    var images: [URL] = []
    var selectedImage : Int = 0
    @IBAction func eventphotBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        let vc = DisplayFolderViewController.instantiate(fromStoryboard: .Main)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func playTapped(_ sender: UIButton) {
        let vc = PhotosSlideShowViewController.instantiate(fromStoryboard: .Main)
        vc.slideImages = images
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
  

    let margin: CGFloat = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.swipeCollection.automaticallyAdjustsScrollIndicatorInsets = false
        self.swipeCollection.autoresizesSubviews = false
        self.swipeCollection.translatesAutoresizingMaskIntoConstraints = false
        automaticallyAdjustsScrollViewInsets = false
        
        labelName.text = headerLabel
//        playbutton.layer.borderWidth = 1
        playbutton.layer.masksToBounds = false
       // playbutton.layer.borderColor = UIColor.black.cgColor
        playbutton.layer.cornerRadius = playbutton.frame.height/2
        playbutton.clipsToBounds = true
        
//        guard let collectionView = swipeCollection, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
//
//            flowLayout.minimumInteritemSpacing = margin
//            flowLayout.minimumLineSpacing = margin
//            flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        swipeCollection.setCollectionViewLayout(layout, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        swipeCollection.dataSource = self
        swipeCollection.delegate = self
        print(images)
        print(selectedImage)
        let index = IndexPath.init(item: selectedImage, section: 0)
        
        self.swipeCollection.scrollToItem(at: index, at: [.centeredHorizontally, .centeredVertically], animated: true)
        swipeCollection.reloadData()
        swipeCollection.layoutSubviews()
       
    }
   
   
    
    
}
extension SwipeImageViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "swipeImage", for: indexPath) as? SwipeImageCollectionViewCell
        let swipe = images[indexPath.item]
            DispatchQueue.global().async {
                 if let data = try? Data( contentsOf: swipe)
                 {
                   DispatchQueue.main.async {
                     cell?.swipeImage.image = UIImage( data:data)
                       
                      
                   }
                 }
              }

        cell?.swipeImage.contentMode = .scaleAspectFill
        
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
//        let m = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
//
//            return CGSize(width: m, height:size )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
