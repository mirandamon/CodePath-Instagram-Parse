//
//  FeedCell.swift
//  ImmediatePhotoRecorder
//
//  Created by Nathan Miranda on 3/6/16.
//  Copyright © 2016 Miraen. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
//        likesLabel.hidden = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
