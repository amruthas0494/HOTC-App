//
//  SwipeImagesVC.swift
//  Photography-HOTC
//
//  Created by apple on 02/11/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

class SwipeImagesVC: UIViewController {
    
    
    @IBOutlet weak var swipeCollection: UICollectionView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var homeButton: UIButton!
    
    var imagesTOBeSlided = [UIImage]()
    var headerLabel: String = ""
    var images: [URL] = []
    var selectedImage : Int = 0
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        let vc = DisplayFolderViewController.instantiate(fromStoryboard: .Main)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        let vc = PhotosSlideShowViewController.instantiate(fromStoryboard: .Main)
        vc.slideImages = images
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    var counter = 0
    var spacing: CGFloat = 8
    let margin: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeCollection.bounds.size = UIScreen.main.bounds.size
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.swipeCollection.automaticallyAdjustsScrollIndicatorInsets = false
        self.swipeCollection.autoresizesSubviews = false
        self.swipeCollection.translatesAutoresizingMaskIntoConstraints = false
        automaticallyAdjustsScrollViewInsets = false
        
        labelName.text = headerLabel
        //        playbutton.layer.borderWidth = 1
        playButton.layer.masksToBounds = false
        // playbutton.layer.borderColor = UIColor.black.cgColor
        playButton.layer.cornerRadius = playButton.frame.height/2
        playButton.clipsToBounds = true
        
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = UIScreen.main.bounds.size
        layout.scrollDirection = .horizontal
        
        
        swipeCollection.setCollectionViewLayout(layout, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(images)
        print(selectedImage)
        let index = IndexPath.init(item: selectedImage, section: 0)
        
        self.swipeCollection.scrollToItem(at: index, at: [.centeredHorizontally, .centeredVertically], animated: true)
        swipeCollection.reloadData()
        swipeCollection.layoutSubviews()
        
    }
 
}
    
extension SwipeImagesVC : UICollectionViewDataSource {
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
                    cell?.swipeImage.image = UIImage( data:data)?.asOriginal
                    cell?.swipeImage.contentMode = .scaleAspectFit
                    
                }
            }
        }
        
        
        
        return cell!
        
    }
    
    
    
    
}
extension SwipeImagesVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let safeFrame = swipeCollection.safeAreaLayoutGuide.layoutFrame
        let size = CGSize(width: safeFrame.width, height: safeFrame.height)
        return CGSize(width: size.width, height: size.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
    
    
    
    
    


