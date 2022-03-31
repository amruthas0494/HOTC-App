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
    var viewImages: [UIImage] = []
    var labelName: String = ""
    var displayLabelName = ""
    var selectedimage : UIImage?
    
    
   
   // var models = [Model]()
    
    @IBOutlet weak var nameOutlet: UILabel!
    
    @IBOutlet weak var eventCollection: UICollectionView!
    
    
    @IBAction func eventkButtonTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func homeTapped(_ sender: UIButton) {
        
        let viewcontroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeScreen") as?  DisplayFolderViewController
        
        self.present(viewcontroller!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for img in viewImages {
//            models = [Model(image: img)]
//        }
//
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
        cell.eventPhotos.image = viewImages[indexPath.item]
  
        return cell
    }
    
}
extension PhotoEventDisplayViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        let selectedItem = self.viewImages[indexPath.row]
       // guard let indexPath = (sender as? UIView)?.findCollectionViewIndexPath() else { return }
             // guard let detailViewController = segue.destination as? DetailViewController else { return }
       
             
        let viewcontroller1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "toSwipe") as?  SwipeImageViewController
        
        
        viewcontroller1?.headerLabel = labelName
        viewcontroller1?.selectedImage = selectedItem
        viewcontroller1?.images = viewImages
        
        self.present(viewcontroller1!, animated: true, completion: nil)
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
        return  viewImages[indexPath.item].size.height
    }

    
}
