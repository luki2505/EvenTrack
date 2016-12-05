//
//  EventsTableViewController.swift
//  bezline
//
//  Created by Lukas on 06.05.16.
//  Copyright © 2016 Lukas. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class EventsTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var eventsToday: [Event] = []
    var eventsTomorrow: [Event] = []
    var eventsSoon:  [Event] = []
    let locationManager = CLLocationManager()
    var userLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
        }
        
        eventsToday = EventManager.getAllToday()
        eventsTomorrow = EventManager.getAllToday()
        eventsSoon  = EventManager.getAllSoon()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        eventsToday = EventManager.getAllToday()
        eventsTomorrow = EventManager.getAllTomorrow()
        eventsSoon  = EventManager.getAllSoon()
        tableView.reloadData()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = manager.location!
        tableView.reloadData()
    }
    
    func calculateDistance(_ source:CLLocation, _ destination:CLLocation) -> String {
        let distance = destination.distance(from: source)
        
        if distance < 1000 {
            // metres ...
            return String(Int(distance)) + " m"
        } else if distance < 10000 {
            let km: Double = distance / 1000;
            return String(format: "%.2f km", km)
        } else {
            let km: Double = distance / 1000;
            return String(format: "%.0f km", km)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return eventsToday.count
        case 1:
            return eventsTomorrow.count
        case 2:
            return eventsSoon.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
        
        cell.titleLabel.textColor = ColorManager.getNavigationColor()
        cell.distanceLabel.textColor = ColorManager.getNavigationColor()
        
        var destinationPlacemark: MKPlacemark?
        
        var sectionArray = [Event]()
        switch (indexPath as NSIndexPath).section {
        case 0:
            sectionArray = eventsToday
        case 1:
            sectionArray = eventsTomorrow
        case 2:
            sectionArray = eventsSoon
        default:
            cell.titleLabel.text = "other"
        }
        
        cell.titleLabel.text = sectionArray[(indexPath as NSIndexPath).row].name
        cell.subtitleLabel.text = sectionArray[(indexPath as NSIndexPath).row].getPlaceName()
        let coordinates = sectionArray[(indexPath as NSIndexPath).row].getCoordinate()
        destinationPlacemark = MKPlacemark(coordinate: coordinates)
        
        let destination = CLLocation(latitude: destinationPlacemark!.coordinate.latitude
            , longitude: destinationPlacemark!.coordinate.longitude)
        
        if userLocation != nil {
            cell.distanceLabel.text = self.calculateDistance(userLocation!, destination)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventHeaderCell") as! EventHeaderTableViewCell
        cell.captionLabel.textColor = ColorManager.getNavigationColor()
        
        switch section {
        case 0:
            cell.captionLabel.text = "today"
        case 1:
            cell.captionLabel.text = "tomorrow"
        case 2:
            cell.captionLabel.text = "soon"
        default:
            cell.captionLabel.text = "other"
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSeague" {
            let destination = segue.destination as! EventDetailViewController
            let section = (tableView.indexPathForSelectedRow! as NSIndexPath).section
            
            switch section {
            case 0:
                destination.event = eventsToday[(tableView.indexPathForSelectedRow! as NSIndexPath).row]
            case 1:
                destination.event = eventsTomorrow[(tableView.indexPathForSelectedRow! as NSIndexPath).row]
            case 2:
                destination.event = eventsSoon[(tableView.indexPathForSelectedRow! as NSIndexPath).row]
            default:
                destination.event = nil
            }
        }
    }

}
