//
//  Event.swift
//  Eventrack
//
//  Created by 20074288 on 25/11/2016.
//  Copyright © 2016 Lukas. All rights reserved.
//

import Foundation
import MapKit

class Event {
    let id: String
    let name: String
    let description: String
    let start: Date
    let end: Date?
    let place: NSDictionary
    let status: String

    init(id: String, name: String, description: String, start: Date, end: Date?, place: NSDictionary, status: String) {
        self.id = id
        self.name = name
        self.description = description
        self.start = start
        self.end = end
        self.place = place
        self.status = status
    }
    
    func getLocation() -> NSDictionary? {
        let location = place.value(forKey: "location") as? NSDictionary
        return location
    }
    
    func getPlaceName() -> String {
        print(place)
        return place.value(forKey: "name") as! String
    }
    
    func getCoordinate() -> CLLocationCoordinate2D {
        let location = getLocation()
        let lat = location!.value(forKey: "latitude") as! Double
        let lng = location!.value(forKey: "longitude") as! Double
        return CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
}
