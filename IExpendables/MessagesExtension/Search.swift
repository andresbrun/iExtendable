//
//  Search.swift
//  IExpendables
//
//  Created by Andres Brun on 23/06/16.
//  Copyright © 2016 Andres Brun. All rights reserved.
//

import Foundation
import Messages

class Search {
    var guests: Int = 2
    var checkin: Date?
    var checkout: Date?
    
    var inspirationKey: String?
    var inspirationName: String?
    
    var selectedOfferID: String?
    var selectedOfferImageURL: String?
    var selectedOfferPrice: String?
    var selectedOfferName: String?
}

extension Search {
    var isSearchable: Bool {
        return inspirationKey != nil
    }
}

extension Search {
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        
        if let inspirationKey = inspirationKey {
            items.append(URLQueryItem(name: "inspirationKey", value: inspirationKey))
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
        if let selectedOfferPrice = selectedOfferPrice {
            items.append(URLQueryItem(name: "selectedOfferPrice", value: selectedOfferPrice))
        }
        if let selectedOfferName = selectedOfferName {
            items.append(URLQueryItem(name: "selectedOfferName", value: selectedOfferName))
        }
        items.append(URLQueryItem(name: "guests", value: String(guests)))
        
        return items
    }
    
    convenience init?(queryItems: [URLQueryItem]) {
        self.init()
        var guests: Int = 2
        var inspirationKey: String?
        var checkin: Date?
        var checkout: Date?
        var selectedOfferID: String?
        var selectedOfferImageURL: String?
        
        for queryItem in queryItems {
            guard let value = queryItem.value else { continue }
            
            if queryItem.name == "inspirationKey" {
                inspirationKey = value
            }
            if queryItem.name == "checkin" {
                guard let timeInterval = Double(value) else { return }
                checkin = Date(timeIntervalSince1970: TimeInterval(timeInterval))
            }
            if queryItem.name == "checkout" {
                guard let timeInterval = Double(value) else { return }
                checkout = Date(timeIntervalSince1970: TimeInterval(timeInterval))
            }
            if queryItem.name == "selectedOfferID" {
                selectedOfferID = value
            }
            if queryItem.name == "selectedOfferImageURL" {
                selectedOfferImageURL = value
            }
            if queryItem.name == "selectedOfferPrice" {
                selectedOfferPrice = value
            }
            if queryItem.name == "selectedOfferName" {
                selectedOfferName = value
            }
            if queryItem.name == "guests" {
                guests = Int(value) ?? 2
            }
            
        }
        
        self.guests = guests
        self.inspirationKey = inspirationKey
        self.checkin = checkin
        self.checkout = checkout
        self.selectedOfferID = selectedOfferID
        self.selectedOfferImageURL = selectedOfferImageURL
    }
}

extension Search {
    convenience init?(message: MSMessage?) {
        guard let messageURL = message?.url else { return nil }
        guard let urlComponents = NSURLComponents(url: messageURL, resolvingAgainstBaseURL: false), queryItems = urlComponents.queryItems else { return nil }
        
        self.init(queryItems: queryItems)
    }
}
