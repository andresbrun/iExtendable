//
//  Inspiration.swift
//  IExpendables
//
//  Created by Andres Brun on 23/06/16.
//  Copyright © 2016 Andres Brun. All rights reserved.
//

import UIKit
import Foundation

class Inspiration {
    let name: String
    let imageURL: String
    var image: UIImage?
    let searchKey: String
    
    init(json: [String: String]) {
        name = json["city_name"]!
        imageURL = json["image"]!
        searchKey = json["search_key"]!
    }
}
