//
//  VideoCollectionCollectionViewCell.swift
//  HOTCC
//
//  Created by apple on 26/10/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
protocol VideosDelegate:AnyObject {
    func videoselectButtonTapped(videoSelected:Video)
}

class VideoCollectionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var videoImage: UIImageView!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var videoLabel: UILabel!
    
    
    @IBOutlet weak var vwContainer: UIView!
    
    var videoadded: Video? {
        didSet {
            if let videoDetails = videoadded {
                videoLabel.text = videoDetails.vtitle
                
           }
            }
        }
    
   
    var delegate: VideosDelegate?
  
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        submitButton.setTitle("", for: .normal)
//        videoLabel.setUp(title: "",
//                      font: UIFont.Poppins.medium.size(FontSize.body_17),
//                      textColor: UIColor.AppColors.blackText, noOfLine: 0)
//
//
//        videoLabel.text = ""
        
//        self.vwContainer.backgroundColor = UIColor.AppColors.navigationBackground
//        self.vwContainer.layer.borderWidth = Constant.viewBorder
//        self.vwContainer.layer.borderColor = UIColor.AppColors.border_Color.cgColor
//        self.imgView.layer.cornerRadius = self.imgView.frame.width/2
//        self.imgView.clipsToBounds = true
       // readMore()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))

        vwContainer.addGestureRecognizer(tap)

        vwContainer.isUserInteractionEnabled = true
       

        // function which is triggered when handleTap is called
       
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        if let videos = videoadded {
            self.delegate?.videoselectButtonTapped(videoSelected: videos)
        }
        
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("Hello World")
      //  self.delegate?.videoselectButtonTapped(videoSelected: videoadded)
        if let videos = videoadded {
            self.delegate?.videoselectButtonTapped(videoSelected: videos)
        }
    }
}
