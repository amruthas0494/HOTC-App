//
//  ImagesSwipeViewController.swift
//  Photography-HOTC
//
//  Created by Amrutha S on 13/09/22.
//  Copyright © 2022 apple. All rights reserved.
//

import UIKit
import SwiftPhotoGallery


class ImagesSwipeViewController: UIViewController, SwiftPhotoGalleryDataSource, SwiftPhotoGalleryDelegate {

    // var imageNames = ["image1.jpeg", "image2.jpeg", "image3.jpeg"]
    var imageNames = [URL]()
        var index: Int = 2

        override func viewDidLoad() {
            super.viewDidLoad()
        }

        @IBAction func didPressShowMeButton(sender: AnyObject) {
            let gallery = SwiftPhotoGallery(delegate: self, dataSource: self)

            gallery.backgroundColor = UIColor.black
            gallery.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.5)
            gallery.currentPageIndicatorTintColor = UIColor.white
            gallery.hidePageControl = false

            present(gallery, animated: true, completion: nil)

            /*
            /// Or load on a specific page like this:

            present(gallery, animated: true, completion: { () -> Void in
                gallery.currentPage = self.index
            })
            */

        }

        // MARK: SwiftPhotoGalleryDataSource Methods

        func numberOfImagesInGallery(gallery: SwiftPhotoGallery) -> Int {
            return imageNames.count
        }

       func imageInGallery(gallery: SwiftPhotoGallery, forIndex: Int) -> UIImage? {
//            let event = imageNames[forIndex]
//            if let data = try? Data( contentsOf: event)
//            {
//              DispatchQueue.main.async {
//                  let image:UIImage  = UIImage(data: data) ?? ""
//                  return image
//                
//              }
//            }
           return nil
       }

        // MARK: SwiftPhotoGalleryDelegate Methods

        func galleryDidTapToClose(gallery: SwiftPhotoGallery) {
            dismiss(animated: true, completion: nil)
        }
    


}
