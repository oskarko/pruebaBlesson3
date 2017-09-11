//
//  LocalCoreDataService.swift
//  blesson3
//
//  Created by Oscar Rodriguez Garrucho on 10/9/17.
//  Copyright © 2017 Oscar Rodriguez Garrucho. All rights reserved.
//

import Foundation

class LocalCoreDataService {
    
    /*
     TO DO
     
     It would be great to implement a real Core Data Service to save the places.
     I did not it to save time. I'm a busy man...
 
     */
    
    
    // Simulate save a new place in Core Data
    func savePlace(place: Place) {
        
        CoreData.places.append(place)
        
    }
    
    // Simulate saves all places in Core Data
    func savePlaces(places: [Place]) {
        
        CoreData.places = places
    }
    
    
    // Simulate return all places from Core Data
    func getAllPlaces() -> [Place] {
        
        return CoreData.places
    }
    
    
}
