//
//  DetailsViewController.swift
//  blesson3
//
//  Created by Oscar Rodriguez Garrucho on 10/9/17.
//  Copyright © 2017 Oscar Rodriguez Garrucho. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addresslabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var place: Place = Place()
    var typesTemp: String = ""
    var ratingTemp: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = place.name
        addresslabel.text = place.vicinity
        
        for type in place.types {
            typesTemp = "\(typesTemp), \(type)"
        }
        typesLabel.text = typesTemp.substring(from: 2)
        
        
        while place.rating > 0 {
            ratingTemp = "\(ratingTemp)\u{2B50}" // star unicode
            place.rating -= 1
        }
        
        ratingTemp = ratingTemp.isEmpty ? "No rating found." : ratingTemp // Default text if no rating found
        ratingLabel.text = "Rating:  \(ratingTemp)"
        
        downloadPhoto()
        
        
    }
    
    
    // Download a real photo from Google if there is a download link.
    func downloadPhoto() {
        
        if (!place.photoreference.isEmpty){
            let urlDownload = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=600&photoreference=\(place.photoreference)&key=AIzaSyCFUCj8MEQTCn6pAa4y2s-mjSkYdsS1GBQ"
            
            let imageV = UIImageView()
            imageV.kf.setImage(with: URL(string: urlDownload)!, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { image in
                self.image.image = imageV.image!
                
            })
        }
        else {
            // We must put a dafault photo here
            print("No photo to download")
            self.image.image = UIImage(named: "no_image_available.png")
        }
        
    }
    
    
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}
