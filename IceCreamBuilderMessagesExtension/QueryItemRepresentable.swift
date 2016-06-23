/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    TODO: Abstract
*/

import Foundation

protocol QueryItemRepresentable {
    var queryItem: URLQueryItem { get }
    
    static var queryItemKey: String { get }
}
