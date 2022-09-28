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
    @IBOutlet weak var labelName: UILabel!
    var imagesTOBeSlided : [UIImage]?
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
    var image : UIImage?
    var counter = 0
    var spacing: CGFloat = 8
    let margin: CGFloat = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeCollection.dataSource = self
        swipeCollection.delegate = self
        swipeCollection.isPagingEnabled = true
        swipeCollection.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "swipeImage")
        let index = IndexPath.init(item: selectedImage, section: 0)
        
        self.swipeCollection.scrollToItem(at: index, at: [.centeredHorizontally, .centeredVertically], animated: true)

        swipeCollection.reloadData()
       
      
//     //   swipeCollection.bounds.size = UIScreen.main.bounds.size
//
//        self.automaticallyAdjustsScrollViewInsets = false
//        self.swipeCollection.automaticallyAdjustsScrollIndicatorInsets = false
//        self.swipeCollection.autoresizesSubviews = false
//        self.swipeCollection.translatesAutoresizingMaskIntoConstraints = false
//        automaticallyAdjustsScrollViewInsets = false
//
        labelName.text = headerLabel
        //        playbutton.layer.borderWidth = 1
        playbutton.layer.masksToBounds = false
        // playbutton.layer.borderColor = UIColor.black.cgColor
        playbutton.layer.cornerRadius = playbutton.frame.height/2
        playbutton.clipsToBounds = true
        
//
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        layout.itemSize = UIScreen.main.bounds.size
//        layout.scrollDirection = .horizontal
//
//
//        swipeCollection.setCollectionViewLayout(layout, animated: false)
//
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        swipeCollection.collectionViewLayout.invalidateLayout()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        swipeCollection.collectionViewLayout = flowLayout
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        print(images)
//        print(selectedImage)
//
//
//
//    }

   


    
    @IBAction func leftSwipeButtonTapped(_ sender: UIButton) {
        
        let collectionBounds = self.swipeCollection.bounds
               let contentOffset = CGFloat(floor(self.swipeCollection.contentOffset.x - collectionBounds.size.width))
               self.moveCollectionToFrame(contentOffset: contentOffset)

    }
    func moveCollectionToFrame(contentOffset : CGFloat) {

           let frame: CGRect = CGRect(x : contentOffset ,y : self.swipeCollection.contentOffset.y ,width : self.swipeCollection.frame.width,height : self.swipeCollection.frame.height)
           self.swipeCollection.scrollRectToVisible(frame, animated: true)
       }
    
    @IBAction func rightSwipeButtonTapped(_ sender: UIButton) {
       
        let collectionBounds = self.swipeCollection.bounds
        let contentOffset = CGFloat(floor(self.swipeCollection.contentOffset.x + collectionBounds.size.width))
        self.moveCollectionToFrame(contentOffset: contentOffset)

   
    }
   
    
}
extension SwipeImageViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "swipeImage", for: indexPath) as! SwipeImageCollectionViewCell
        let swipe = images[indexPath.item]
//
        DispatchQueue.global().async {
            if let data = try? Data( contentsOf: swipe)
            {
                DispatchQueue.main.async {
                    cell.swipeImage.image = UIImage( data:data)?.asOriginal
                    cell.swipeImage.contentMode = .scaleAspectFit
                  
                   
                }
                self.selectedImage = indexPath.item
            }
        }
        
       
        return cell
       
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewcontroller = ShowImageVC.instantiate(fromStoryboard: .Main)
        let imageSelect = swipeCollection.cellForItem(at: indexPath)
        viewcontroller.imageSelected = images[indexPath.item]
        viewcontroller.modalPresentationStyle = .overCurrentContext
        self.present(viewcontroller, animated: false)
       
       // self.navigationController?.pushViewController(viewcontroller, animated: true)
        

     
    }
    
    
}
extension SwipeImageViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let safeFrame = swipeCollection.safeAreaLayoutGuide.layoutFrame
        //let size = CGSize(width: safeFrame, height: safeFrame)
        return CGSize(width: safeFrame.width, height: safeFrame.height)
        
        
        
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
        print(UIDevice.current.orientation.isLandscape)
        swipeCollection.collectionViewLayout.invalidateLayout()
        DispatchQueue.main.async {
            let index = IndexPath.init(item: self.selectedImage, section: 0)
        print(self.selectedImage)
          
                self.swipeCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
               
            }
       
       
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
   
    
}

extension UICollectionView {
  var visibleCurrentCellIndexPath: IndexPath? {
    for cell in self.visibleCells {
      let indexPath = self.indexPath(for: cell)
      return indexPath
    }
    
    return nil
  }
}
