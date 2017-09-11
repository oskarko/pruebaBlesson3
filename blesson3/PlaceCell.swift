//
//  PlaceCell.swift
//  blesson3
//
//  Created by Oscar Rodriguez Garrucho on 10/9/17.
//  Copyright © 2017 Oscar Rodriguez Garrucho. All rights reserved.
//

import UIKit
import Kingfisher

class PlaceCell: UITableViewCell {

    @IBOutlet weak var imagePlace: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func configCellWithOptions(place: Place) {
        
        nameLabel.text = place.name
        addressLabel.text = place.vicinity
        
        let imageV = UIImageView()
        imageV.kf.setImage(with: URL(string: place.icon)!, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { image in
            self.imagePlace.image = imageV.image!

        })
    }

}
