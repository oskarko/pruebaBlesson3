//
//  Place.swift
//  blesson3
//
//  Created by Oscar Rodriguez Garrucho on 10/9/17.
//  Copyright © 2017 Oscar Rodriguez Garrucho. All rights reserved.
//

import Foundation
import CoreLocation

class Place: NSObject {
    
    var id: String = ""
    var vicinity: String = ""
    var location: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var placeId: String = ""
    var reference: String = ""
    var name: String = ""
    var types: [String] = [String]()
    var icon: String = ""
    var rating: Int = 0
    var photoreference: String = ""
    
    
    override init() {
        super.init()
    }
    
    
    init(id: String, vicinity: String, placeId: String, reference: String, name: String, rating: Int, icon: String, location: CLLocationCoordinate2D, types: [String], photoreference: String){
        
        self.id = id
        self.vicinity = vicinity
        self.placeId = placeId
        self.reference = reference
        self.name = name
        self.rating = rating
        self.icon = icon
        self.location = location
        self.types = types
        self.photoreference = photoreference
    }
        
}
