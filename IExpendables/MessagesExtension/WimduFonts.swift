//
//  WimduFonts.swift
//  Guest
//
//  Created by Andres Brun on 11/05/15.
//  Copyright (c) 2015 Wimdu. All rights reserved.
//

import Foundation
import UIKit

let regularFontName = "OpenSans"
let semiboldFontName = "OpenSans-Semibold"
let lightFontName = "OpenSans-Light"

enum WimduFont {
    case Title
    case TitleBig
    case TitleLight
    case Subtitle
    case Subtitle1
    case Subtitle2
    case Subtitle3
    case Body1
    case Body2
    case Small1
    case Small2
    case Small3
    case Tiny
    case Secured
    case RegularLarge
    case SemiboldLarge
    case SemiboldNormal
    case SemiboldSmall
    
    var font: UIFont {
        switch self {
        case .Title: return UIFont(name: regularFontName, size: 18)!
        case .TitleBig: return UIFont(name: regularFontName, size: 24)!
        case .TitleLight: return UIFont(name: lightFontName, size: 18)!
        case .Subtitle: return UIFont(name: regularFontName, size: 16)!
        case .Subtitle1: return UIFont(name: regularFontName, size: 15)!
        case .Subtitle2: return UIFont(name: regularFontName, size: 14)!
        case .Subtitle3: return UIFont(name: regularFontName, size: 16)!
        case .Body1: return UIFont(name: lightFontName, size: 15)!
        case .Body2: return UIFont(name: lightFontName, size: 14)!
        case .Small1: return UIFont(name: lightFontName, size: 13)!
        case .Small2: return UIFont(name: regularFontName, size: 12)!
        case .Small3: return UIFont(name: lightFontName, size: 12)!
        case .Tiny: return UIFont(name: regularFontName, size: 10)!
        case .Secured: return .systemFont(ofSize: 15.0)
        case .RegularLarge: return UIFont(name: regularFontName, size: 20)!
        case .SemiboldLarge: return UIFont(name: semiboldFontName, size: 20)!
        case .SemiboldNormal: return UIFont(name: semiboldFontName, size: 15)!
        case .SemiboldSmall:  return UIFont(name: semiboldFontName, size: 13)!
        }
    }
}
