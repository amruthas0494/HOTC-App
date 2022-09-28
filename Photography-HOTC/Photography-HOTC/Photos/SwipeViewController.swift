//
//  SwipeViewController.swift
//  Photography-HOTC
//
//  Created by Amrutha S on 31/08/22.
//  Copyright © 2022 apple. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController {

    
    @IBOutlet weak var swipeImage: UIImageView!
    var currentImage = 0
    var imageNames: [URL] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var swipeRight = UISwipeGestureRecognizer(target: self, action:#selector(respondToSwipeGesture(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
            self.view.addGestureRecognizer(swipeRight)

        var swipeLeft = UISwipeGestureRecognizer(target: self, action:#selector(respondToSwipeGesture(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
            self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

           if let swipeGesture = gesture as? UISwipeGestureRecognizer {


               switch swipeGesture.direction {
               case UISwipeGestureRecognizer.Direction.left:
                   if currentImage == imageNames.count - 1 {
                       currentImage = 0

                   }else{
                       currentImage += 1
                   }
                  
                       DispatchQueue.global().async {
                           if let data = try? Data( contentsOf: self.imageNames[self.currentImage])
                            {
                              DispatchQueue.main.async {
                                  self.swipeImage.image = UIImage( data:data)
                                
                              }
                            }
                         }
                 

               case UISwipeGestureRecognizer.Direction.right:
                   if currentImage == 0 {
                       currentImage = imageNames.count - 1
                   }else{
                       currentImage -= 1
                   }
                   DispatchQueue.global().async {
                       if let data = try? Data( contentsOf: self.imageNames[self.currentImage])
                        {
                          DispatchQueue.main.async {
                              self.swipeImage.image = UIImage( data:data)
                            
                          }
                        }
                     }
             
               default:
                   break
               }
           }
       }
       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }



}
