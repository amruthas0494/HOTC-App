//
//  ImagePreviewVC.swift
//  photosApp2
//
//  Created by Muskan on 10/4/17.
//  Copyright © 2017 akhil. All rights reserved.
//

import UIKit

class ImagePreviewVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    var myCollectionView: UICollectionView!
    let backButton = UIButton()
    let homeButton = UIButton()
    let backImage:UIImageView = UIImageView()
    let homeImage:UIImageView = UIImageView()
    let appIcon:UIImageView = UIImageView()
    
    var imagesFromPrevious:[UIImage] = []
    var passedContentOffset = IndexPath()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor=UIColor.black
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing=0
        layout.minimumLineSpacing=0
        layout.scrollDirection = .horizontal
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.register(ImagePreviewFullViewCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.isPagingEnabled = true
        print(passedContentOffset)
        print(imagesFromPrevious)
        myCollectionView.scrollToItem(at: passedContentOffset, at: .left, animated: true)
        setButtons()
        self.view.addSubview(myCollectionView)
        self.view.addSubview(backButton)
        self.view.addSubview(homeButton)
        self.view.addSubview(backImage)
        self.view.addSubview(homeImage)
        self.view.addSubview(appIcon)
        myCollectionView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleHeight.rawValue)))
        
        homeButton.layer.cornerRadius = homeButton.layer.frame.size.width/2
        backButton.layer.cornerRadius = backButton.layer.frame.size.width/2
    }
    
    func setButtons(){
        
        backImage.contentMode = UIView.ContentMode.scaleAspectFit
        backImage.frame.size.width = 200
        backImage.frame.size.height = 200
        backImage.frame = CGRect(x: 38, y: 62, width: 25, height: 25)
        backImage.image = UIImage(systemName: "chevron.left")
        backImage.tintColor = .black
        
        backButton.setTitle("", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.frame = CGRect(x: 28, y: 49, width: 50, height: 50)
        backButton.backgroundColor = .white
        backButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        
        homeImage.contentMode = UIView.ContentMode.scaleAspectFit
        homeImage.frame.size.width = 200
        homeImage.frame.size.height = 200
        homeImage.frame = CGRect(x: 928, y: 58, width: 30, height: 30)
        homeImage.image = UIImage(systemName: "house.fill")
        homeImage.tintColor = .black
        
        
        
        homeButton.setTitle("", for: .normal)
        homeButton.setTitleColor(.white, for: .normal)
        homeButton.backgroundColor = .white
        homeButton.frame = CGRect(x: 918, y: 49, width: 50, height: 50)
        homeButton.addTarget(self, action: #selector(homePressed), for: .touchUpInside)
        
        appIcon.contentMode = UIView.ContentMode.scaleAspectFit
        appIcon.frame.size.width = 200
        appIcon.frame.size.height = 200
        appIcon.frame = CGRect(x: 927, y: 694, width: 64, height: 54)
        appIcon.image = UIImage(named: "appstore")
        appIcon.tintColor = .white
        
        
        
    }
    
    
    
    @objc func pressed() {
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "PhotoViewController")
        self.navigationController?.popViewController(animated: true)
        
        
    }
    @objc func homePressed() {
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesFromPrevious.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImagePreviewFullViewCell
        cell.imgView.image = imagesFromPrevious[indexPath.row]
        return cell
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let flowLayout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        flowLayout.itemSize = myCollectionView.frame.size
        
        flowLayout.invalidateLayout()
        
        myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let offset = myCollectionView.contentOffset
        let width  = myCollectionView.bounds.size.width
        
        let index = round(offset.x / width)
        let newOffset = CGPoint(x: index * size.width, y: offset.y)
        
        myCollectionView.setContentOffset(newOffset, animated: false)
        
        coordinator.animate(alongsideTransition: { (context) in
            self.myCollectionView.reloadData()
            
            self.myCollectionView.setContentOffset(newOffset, animated: false)
        }, completion: nil)
    }
    
}


class ImagePreviewFullViewCell: UICollectionViewCell, UIScrollViewDelegate {
    
    var scrollImg: UIScrollView!
    var imgView: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollImg = UIScrollView()
        scrollImg.delegate = self
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.flashScrollIndicators()
        
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 4.0
        
        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scrollImg.addGestureRecognizer(doubleTapGest)
        
        self.addSubview(scrollImg)
        
        imgView = UIImageView()
        imgView.image = UIImage(named: "user3")
        scrollImg.addSubview(imgView!)
        imgView.contentMode = .scaleAspectFit
        
    }
    
    
    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollImg.zoomScale == 1 {
            scrollImg.zoom(to: zoomRectForScale(scale: scrollImg.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            scrollImg.setZoomScale(1, animated: true)
        }
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imgView.frame.size.height / scale
        zoomRect.size.width  = imgView.frame.size.width  / scale
        let newCenter = imgView.convert(center, from: scrollImg)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imgView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollImg.frame = self.bounds
        imgView.frame = self.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scrollImg.setZoomScale(1, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

