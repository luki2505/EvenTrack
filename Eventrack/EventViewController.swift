//
//  EventViewController.swift
//  Eventrack
//
//  Created by Lukas on 25.11.16.
//  Copyright © 2016 Lukas. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    // Mark: Properties
    @IBOutlet var designViewUnderNavigation: UIView!
    @IBOutlet var mapContainer: UIView!
    @IBOutlet var listContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
    }

    func prepareUI() {
        designViewUnderNavigation.backgroundColor = ColorManager.getNavigationColor()
    }
    
    // MARK: Action
    
    @IBAction func showComponent(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.mapContainer.alpha = 1
                self.listContainer.alpha = 0
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.mapContainer.alpha = 0
                self.listContainer.alpha = 1
            })
        }
    }
    
    // MARK: Navigation
    
    @IBAction func unwindCancel(_ sender: UIStoryboardSegue) {}
    
    @IBAction func unwindSave(_ sender: UIStoryboardSegue) {
        print("event saved!")
    }

}
