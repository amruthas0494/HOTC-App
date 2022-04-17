//
//  PhotoEventDisplayViewController.swift
//  HOTCC
//
//  Created by apple on 26/10/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit


//struct Model {
//    let image: UIImage
//    //let title: String
//
//    var inputSource: InputSource {
//        return ImageSource(image: image)
//    }
//}


class PhotoEventDisplayViewController: UIViewController {
    
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(
        top: 5.0,
        left: 2.0,
        bottom: 5.0,
        right: 2.0)
    var items = [ItemModel]()
    var viewImages: [URL] = []
    var labelName: String = ""
    var displayLabelName = ""
    var selectedimage : UIImage?
    var swipImages: [UIImage] = []
    
    
   
   // var models = [Model]()
    
    @IBOutlet weak var nameOutlet: UILabel!
    
    @IBOutlet weak var eventCollection: UICollectionView!
    
    
    @IBAction func eventkButtonTapped(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func homeTapped(_ sender: UIButton) {
        let vc = DisplayFolderViewController.instantiate(fromStoryboard: .Main)
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // print(viewImages)
        
      self.nameOutlet.text = labelName
        eventCollection.dataSource = self
        eventCollection.delegate = self
        
        eventCollection.backgroundColor = .clear
        loadData()
        
        setupCollectionViewLayout()
        if let layout = eventCollection?.collectionViewLayout as? CustomLayout {
                 layout.delegate = self
               }
               eventCollection.backgroundColor = .clear
    }
    
    func loadData() {
        for _ in viewImages {
            items.append(ItemModel(width: getRandomNumber(), height: getRandomNumber()))
        }
        self.eventCollection.reloadData()
    }
    
    
    func getRandomNumber() -> Int {
        return Int.random(in: 250..<500)
    }
    
    
    
    
    func setupCollectionViewLayout() {
        
        // Create a waterfall layout
        let layout = CHTCollectionViewWaterfallLayout()
        
        // Change individual layout attributes for the spacing between cells
        layout.minimumColumnSpacing = 3.0
        layout.minimumInteritemSpacing = 3.0
        
        // Set the waterfall layout to your collection view
        self.eventCollection.collectionViewLayout = layout
    }
    
    
}

extension PhotoEventDisplayViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photEvent", for: indexPath) as! PhotoEventCollectionViewCell
        let event = viewImages[indexPath.item]
            DispatchQueue.global().async {
                 if let data = try? Data( contentsOf: event)
                 {
                   DispatchQueue.main.async {
                     cell.eventPhotos.image = UIImage( data:data)
                     
                   }
                 }
              }

        return cell
    }
    
}
extension PhotoEventDisplayViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewcontroller = SwipeImageViewController.instantiate(fromStoryboard: .Main)
     
        viewcontroller.headerLabel = labelName
        viewcontroller.selectedImage = indexPath.item
        viewcontroller.images = viewImages
        self.navigationController?.pushViewController(viewcontroller, animated: true)

     
    }
    
}

extension PhotoEventDisplayViewController: CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: items[indexPath.row].width, height: items[indexPath.row].height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnCountFor section: Int) -> Int {
        return 3
    }
    
}

//connecting with vc to implement layout delegate
extension PhotoEventDisplayViewController : CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return  swipImages[indexPath.item].size.height
    }

    
}
