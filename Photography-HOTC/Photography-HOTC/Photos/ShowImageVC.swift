//
//  ShowImageVC.swift
//  Photography-HOTC
//
//  Created by Amrutha S on 26/09/22.
//  Copyright © 2022 apple. All rights reserved.
//

import UIKit

class ShowImageVC: UIViewController {

    
    @IBOutlet weak var showImage: UIImageView!
    
    var imageSelected : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(imageSelected)
        // Do any additional setup after loading the view.
        DispatchQueue.global().async {
            if let imageChoosen = self.imageSelected {
                if let data = try? Data( contentsOf: imageChoosen)
                {
                    DispatchQueue.main.async {
                        self.showImage.image = UIImage( data:data)?.asOriginal
                   
                       
                        
                    }
                }
            }
            
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        showImage.isUserInteractionEnabled = true
        showImage.addGestureRecognizer(tap)
        
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        self.dismissVC()
      //  self.navigationController?.popViewController(animated: true)
    }

}
