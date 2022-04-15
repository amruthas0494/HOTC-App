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
        vc.Images = imagesTOBeSlided
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelName.text = headerLabel
        
       // print(imagesTOBeSlided)
        
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        swipeCollection.dataSource = self
        swipeCollection.delegate = self
        let index = IndexPath.init(item: selectedImage, section: 0)
        self.swipeCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        swipeCollection.reloadData()
    }
    
    
    
}
extension SwipeImageViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesTOBeSlided.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "swipeImage", for: indexPath) as? SwipeImageCollectionViewCell
        cell?.swipeImage.image = imagesTOBeSlided[indexPath.item]
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
