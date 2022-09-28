//
//  SwipeLeftRightViewController.swift
//  Photography-HOTC
//
//  Created by Amrutha S on 28/09/22.
//  Copyright © 2022 apple. All rights reserved.
//

import UIKit

class SwipeLeftRightViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var imagesTOBeSlided = [UIImage]()
    var headerLabel: String = ""
    var images: [URL] = []
    var selectedImage : Int?
    var image : UIImage?
    var counter = 0
    var spacing: CGFloat = 8
    let margin: CGFloat = 10
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var labelName: UILabel!
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(images)
        collectionView.bounds.size = UIScreen.main.bounds.size
        labelName.text = headerLabel
        //        playbutton.layer.borderWidth = 1
        playButton.layer.masksToBounds = false
        // playbutton.layer.borderColor = UIColor.black.cgColor
        playButton.layer.cornerRadius = playButton.frame.height/2
        playButton.clipsToBounds = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        collectionView.reloadData()
        collectionView.layoutSubviews()
//        if selectedImage > 1  {
//            let index = IndexPath.init(item: selectedImage - 1, section: 0)
//            self.collectionView.scrollToItem(at: index, at: [.centeredHorizontally, .centeredVertically], animated: true)
//        }else {
//            let index = IndexPath.init(item: selectedImage, section: 0)
//            self.collectionView.scrollToItem(at: index, at: [.centeredHorizontally, .centeredVertically], animated: true)
//        }
       
      
      
    }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            print(images)
            print(selectedImage)
    
            let index = IndexPath.init(item: selectedImage ?? 0, section: 0)
            self.collectionView.scrollToItem(at: index, at: [.centeredHorizontally, .centeredVertically], animated: true)
            
    
        }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flowLayout
    }
    @IBAction func leftSwipeButtonTapped(_ sender: UIButton) {
        
        let collectionBounds = self.collectionView.bounds
               let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x - collectionBounds.size.width))
               self.moveCollectionToFrame(contentOffset: contentOffset)
    

    }
   
    
    @IBAction func rightSwipeButtonTapped(_ sender: UIButton) {
       
        let collectionBounds = self.collectionView.bounds
        let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + collectionBounds.size.width))
        self.moveCollectionToFrame(contentOffset: contentOffset)

   
    }
    func moveCollectionToFrame(contentOffset : CGFloat) {

           let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionView.contentOffset.y ,width : self.collectionView.frame.width,height : self.collectionView.frame.height)
           self.collectionView.scrollRectToVisible(frame, animated: true)
       }
    

}
extension SwipeLeftRightViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let swipe = images[indexPath.item]
        DispatchQueue.global().async {
            if let data = try? Data( contentsOf: swipe)
            {
                DispatchQueue.main.async {
                    cell.userImageView.image = UIImage( data:data)?.asOriginal
                    cell.userImageView.contentMode = .scaleAspectFit
                    self.selectedImage = indexPath.item
                    
                }
            }
        }
        
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewcontroller = ShowImageVC.instantiate(fromStoryboard: .Main)
        let imageSelect = collectionView.cellForItem(at: indexPath)
        viewcontroller.imageSelected = images[indexPath.item]
        viewcontroller.modalPresentationStyle = .overCurrentContext
        self.present(viewcontroller, animated: false)
       
     

     
    }
    
    
}
extension SwipeLeftRightViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.safeAreaLayoutGuide.layoutFrame
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
   
    
}
