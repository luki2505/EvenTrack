//
//  EventDetailViewController.swift
//  bezline
//
//  Created by Lukas on 06.05.16.
//  Copyright © 2016 Lukas. All rights reserved.
//

import UIKit
import MapKit
import Social

class EventDetailViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var eventLabel: UILabel!
    @IBOutlet var openLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var fbeventLabel: UILabel!
    @IBOutlet var fbeventButton: UIButton!
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        loadEventData()
    }
    
    func prepareUI() {
        eventLabel.textColor = ColorManager.getNavigationColor()
        eventLabel.layer.addSublayer(BorderManager.getBottom(eventLabel))
    }
    
    
    func loadEventData() {
        // mapView
        let pin = MKPointAnnotation()
        pin.coordinate = event!.getCoordinate()
        pin.title = event!.name
        mapView.addAnnotation(pin)
        mapView.showAnnotations(mapView.annotations, animated: true)
        
        // Name
        eventLabel.text = event!.name
        
        // Opening Hours
        let hours = formatDateToString(event!.start, event!.end)
        openLabel.text = hours
        
        // Location
        locationLabel.text = event!.getPlaceName()
    }
    
    @IBAction func fbEventTapped(_ sender: UIButton) {
        print("view fb event " + event!.id)
        
        UIApplication.tryURL([
            "http://www.facebook.com/events/" + event!.id
            ])
    }
    
    @IBAction func navigateButtonTapped(_ sender: UIButton) {
        let lat = event!.getCoordinate().latitude
        let lng = event!.getCoordinate().longitude
        
        let coordinate = CLLocationCoordinate2DMake(lat, lng)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = event!.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    
    func formatDateToString(_ start: Date, _ end: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        var startText = ""
        var endText = ""
        
        // start
        if Calendar.current.isDateInToday(start) {
            startText = "Today " + dateFormatter.string(from: start)
        } else if Calendar.current.isDateInTomorrow(start) {
            startText = "Tomorrow " + dateFormatter.string(from: start)
        } else {
            dateFormatter.dateStyle = .medium
            startText = dateFormatter.string(from: start)
        }
        
        // time difference between start and end
        let calendar: Calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: start)
        
        if end != nil {
            let date2 = calendar.startOfDay(for: end!)
            let components = (calendar as NSCalendar).components(.day, from: date1, to: date2, options: .matchFirst)
            
            // end
            if components.day! < 2 {
                dateFormatter.dateStyle = .none
            } else {
                dateFormatter.dateStyle = .medium
            }
            endText = dateFormatter.string(from: end!)
            
            return startText + " - " + endText
        } else {
            return startText
        }
    }
}
