//
//  DateExtension.swift
//  IExpendables
//
//  Created by Hani Ibrahim on 6/23/16.
//  Copyright © 2016 Andres Brun. All rights reserved.
//

import Foundation

extension Date {
    var simpleString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "dd MMM", options: 0, locale: .current())
        return dateFormatter.string(from: self)
    }
}
