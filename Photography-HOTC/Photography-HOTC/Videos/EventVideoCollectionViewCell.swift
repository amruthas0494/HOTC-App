//
//  EventVideoCollectionViewCell.swift
//  HOTCC
//
//  Created by apple on 27/10/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit


class EventVideoCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var displayTumbnail: UIImageView!
    
    @IBOutlet weak var videoButton: UIButton!
    var thumbNailadded: URL? {
        didSet {
            if let thumbNailDetails = thumbNailadded {
               // videoLabel.text = videoDetails.vtitle
                DispatchQueue.global().async {
                    if let data = try? Data( contentsOf: thumbNailDetails)
                {
                  DispatchQueue.main.async {
                    self.displayTumbnail.image = UIImage( data:data)
                  }
                }
             }
                
           }
            }
        }
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("thumNail", thumbNailadded)
       

        // function which is triggered when handleTap is called
       
    }
}
