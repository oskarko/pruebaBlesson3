//
//  ConnectionService.swift
//  blesson3
//
//  Created by Oscar Rodriguez Garrucho on 10/9/17.
//  Copyright © 2017 Oscar Rodriguez Garrucho. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation


class ConnectionServices {
    
    
    // get new places around you with Alamofire
    func getNewPlaces(place: String, completionHandler: @escaping ([Place]?) -> Void) {
        
        
        if (UserDefaults.standard.object(forKey: "latitude") != nil) {
            
            let lat: String = UserDefaults.standard.string(forKey: "latitude")!
            let lng: String = UserDefaults.standard.string(forKey: "longitude")!
            
            // Replacing strange characters
            let placeCoded: String = place.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "Á", with: "A").replacingOccurrences(of: "Ó", with: "O").replacingOccurrences(of: "É", with: "E").replacingOccurrences(of: "Í", with: "I").replacingOccurrences(of: "Ú", with: "U").replacingOccurrences(of: "á", with: "a").replacingOccurrences(of: "é", with: "e").replacingOccurrences(of: "í", with: "i").replacingOccurrences(of: "ó", with: "o").replacingOccurrences(of: "ö", with: "o").replacingOccurrences(of: "ú", with: "u").replacingOccurrences(of: "ü", with: "u")
            
            // I have fixed the radius value for testing
            let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(lng)&radius=50000&name=\(placeCoded)&key=AIzaSyCFUCj8MEQTCn6pAa4y2s-mjSkYdsS1GBQ")!
            
            Alamofire.request(url,
                              method: .get,
                              parameters: nil,
                              encoding: URLEncoding.default,
                              headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                                
                                switch response.result {
                                case .success:
                                    
                                    var result = [Place]()
                                    
                                    if let value = response.result.value {
                                        
                                        let json = JSON(value)
                                        print("RESULT \(json)")
                                        
                                        let results = JSON(json["results"].object)
                                        let allNewPlaces = results.array
                                        
                                        if let allNewPlaces = allNewPlaces {
                                            
                                            for newPlace in allNewPlaces {
                                                
                                                let place: Place = Place()
                                                
                                                place.id = newPlace["id"].stringValue
                                                place.rating = newPlace["rating"].intValue
                                                place.vicinity = newPlace["vicinity"].stringValue
                                                place.location =  CLLocationCoordinate2D(latitude: CLLocationDegrees(newPlace["geometry"]["location"]["lat"].floatValue),
                                                                                         longitude: CLLocationDegrees(newPlace["geometry"]["location"]["lng"].floatValue))
                                                place.icon = newPlace["icon"].stringValue
                                                place.placeId = newPlace["place_id"].stringValue
                                                place.reference = newPlace["reference"].stringValue
                                                place.name = newPlace["name"].stringValue
                                                
                                                let types = newPlace["types"].arrayValue
                                                
                                                for type in types {
                                                    place.types.append("\(type)")
                                                }
                                                
                                                let photoObjects = newPlace["photos"].arrayValue
                                                
                                                if (photoObjects.count > 0){
                                                    print("CATCHED PHOTO \(photoObjects[0]["photo_reference"].stringValue)")
                                                    place.photoreference = photoObjects[0]["photo_reference"].stringValue
                                                    
                                                }
                                                
                                                result.append(place)
                                            }
                                            
                                        }
                                        
                                    }
                                    completionHandler(result)
                                case .failure(let error):
                                    print("RESPONSE GET NEW PLACES ERROR: \(error)")
                                    completionHandler(nil)
                                }
                                
            }
        }
        else {
            completionHandler(nil) // No Location found!
        }
        
    }
    
    
    
    
}
