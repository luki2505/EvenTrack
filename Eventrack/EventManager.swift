//
//  EventManager.swift
//  Eventrack
//
//  Created by 20074288 on 25/11/2016.
//  Copyright © 2016 Lukas. All rights reserved.
//

import Foundation

class EventManager {
    
    static var events = [Event]()
    
    static func add(event: Event) {
        events.append(event)
    }
    
    static func getAll() -> [Event] {
        return events
    }
    
    static func getAllToday() -> [Event] {
        var res = [Event]()
        
        for event in events {
            if Calendar.current.isDateInToday(event.start as Date) {
                res.append(event)
            }
        }
        return res
    }
    
    static func getAllTomorrow() -> [Event] {
        var res = [Event]()
        
        for event in events {
            if Calendar.current.isDateInTomorrow(event.start as Date) {
                res.append(event)
            }
        }
        return res
    }
    
    static func getAllSoon() -> [Event] {
        var res = [Event]()
        
        for event in events {
            if !Calendar.current.isDateInToday(event.start) && !Calendar.current.isDateInTomorrow(event.start) && event.start > Date() {
                res.append(event)
            }
        }
        return res
    }
    
    static func getFromName(name: String) -> Event? {
        for event in events {
            if event.name == name {
                return event
            }
        }
        return nil
    }
}
