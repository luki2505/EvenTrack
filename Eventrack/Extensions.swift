//
//  Extensions.swift
//  bezline
//
//  Created by Lukas on 04.05.16.
//  Copyright © 2016 Lukas. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    func toImage() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        self.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension Calendar
{
    func isDateInNextWeek(_ value: Date) -> Bool
    {
        let today = Date()
        let nextWeek = (Calendar.current as NSCalendar).date(byAdding: .day, value: 7, to: Date(), options: [])!
        
        if value.timeIntervalSinceNow > today.timeIntervalSinceNow && value.timeIntervalSinceNow < nextWeek.timeIntervalSinceNow {
            return true
        }
        
        return false
    }
}

extension UIApplication {
    class func tryURL(_ urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(URL(string: url)!) {
                application.open(URL(string: url)!, options: [:], completionHandler: nil)
                return
            }
        }
    }
}
