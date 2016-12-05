//
//  LoadingViewController.swift
//  Eventrack
//
//  Created by Lukas on 25.11.16.
//  Copyright © 2016 Lukas. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Firebase

class LoadingViewController: UIViewController {
    
    // MARK: Properties
    var user: FIRAuth?
    @IBOutlet var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
    
        print("Hallo " + (user!.currentUser?.email)!)
        loadEventsFromFacebook()
    }
    
    func loadEventsFromFacebook() {
        // friends only returns the friend that use this app! (so in this case none)
        let params = ["fields": "name, events, friends"]
        // you could modify the request that only future events are shown, but for testing reasons i skip this)
        // me/events?since={TIMESTAMP}
        let graphReq = FBSDKGraphRequest(graphPath: "me", parameters: params)
        graphReq?.start(completionHandler: {
            (response, result, error) in
            // Check for errors
            if error != nil {
                print(error!)
                return
            }
            
            // Successfull
            if let data = result as? NSDictionary {
                // TODO: Include the events of the users friends!
                // But the user need friends that actually authenticated this application.
                let friendsData = data["friends"] as! NSDictionary
                // ...
                
                //let id = data["id"] as! String
                //let name = data["name"] as! String
                let eventData = data["events"] as! NSDictionary
                let events = eventData.value(forKey: "data") as! NSArray
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
                for event in events {
                    let e = event as! NSDictionary
                    let id = e.value(forKey: "id") as! String
                    let name = e.value(forKey: "name") as! String
                    let description = e.value(forKey: "description") as! String
                    let startString = e.value(forKey: "start_time") as! String
                    let start = formatter.date(from: startString)!
                    var end: Date?
                    if let endString = e.value(forKey: "end_time") as? String {
                        end = formatter.date(from: endString)!
                    }
                    let place = e.value(forKey: "place") as! NSDictionary
                    let status = e.value(forKey: "rsvp_status") as! String
                    let newEvent = Event(id: id, name: name, description: description, start: start, end: end, place: place, status: status)
                    
                    // only add the events that have a location
                    if newEvent.getLocation() != nil {
                        EventManager.add(event: newEvent)
                    }
                }
                
                print("Successfully loaded \(EventManager.getAll().count) events" )
                self.indicator.stopAnimating()
                self.performSegue(withIdentifier: "DataLoadedSegue", sender: nil)
            }
            
        })
        
    }
    

}
