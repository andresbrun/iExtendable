//
//  Search.swift
//  IExpendables
//
//  Created by Andres Brun on 23/06/16.
//  Copyright © 2016 Andres Brun. All rights reserved.
//

import Foundation

struct Search {
    var guests: Int = 2
    var inspirationID: String?
    var checkin: NSDate?
    var checkout: NSDate?
    var selectedOfferID: String?
    var selectedOfferImageURL: String?
}

extension Search {
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        
        if let inspirationID = inspirationID {
            items.append(URLQueryItem(name: "inspirationID", value: inspirationID))
        }
        if let checkin = checkin {
            items.append(URLQueryItem(name: "checkin", value: String(checkin.timeIntervalSince1970)))
        }
        if let checkout = checkout {
            items.append(URLQueryItem(name: "checkout", value: String(checkout.timeIntervalSince1970)))
        }
        if let selectedOfferID = selectedOfferID {
            items.append(URLQueryItem(name: "selectedOfferID", value: selectedOfferID))
        }
        if let selectedOfferImageURL = selectedOfferImageURL {
            items.append(URLQueryItem(name: "selectedOfferImageURL", value: selectedOfferImageURL))
        }
        items.append(URLQueryItem(name: "guests", value: String(guests)))
        
        return items
    }
    
    init?(queryItems: [URLQueryItem]) {
        var guests: Int = 2
        var inspirationID: String?
        var checkin: NSDate?
        var checkout: NSDate?
        var selectedOfferID: String?
        var selectedOfferImageURL: String?
        
        for queryItem in queryItems {
            guard let value = queryItem.value else { continue }
            
            if queryItem.name == "inspirationID" {
                inspirationID = value
            }
            if queryItem.name == "checkin" {
                guard let timeInterval = Double(value) else { return }
                checkin = NSDate(timeIntervalSince1970: TimeInterval(timeInterval))
            }
            if queryItem.name == "checkout" {
                guard let timeInterval = Double(value) else { return }
                checkout = NSDate(timeIntervalSince1970: TimeInterval(timeInterval))
            }
            if queryItem.name == "selectedOfferID" {
                selectedOfferID = value
            }
            if queryItem.name == "selectedOfferImageURL" {
                selectedOfferImageURL = value
            }
            if queryItem.name == "guests" {
                guests = Int(value) ?? 2
            }
            
        }
        
        self.guests = guests
        self.inspirationID = inspirationID
        self.checkin = checkin
        self.checkout = checkout
        self.selectedOfferID = selectedOfferID
        self.selectedOfferImageURL = selectedOfferImageURL
    }
}
