//
//  UIWimduColor.swift
//  Guest
//
//  Created by Andres Brun on 11/05/15.
//  Copyright (c) 2015 Wimdu. All rights reserved.
//

import UIKit

extension UIColor {
    static func white() -> UIColor {
        return UIColor(netHex: 0xFFFFFF)
    }
    
    static func wBlue() -> UIColor {
        return UIColor(netHex: 0x006CB7)
    }
    
    static func wLightBlue() -> UIColor {
        return UIColor(netHex: 0xB2D3EA)
    }
    
    static func wNightGrey() -> UIColor {
        return UIColor(netHex: 0x404257)
    }
    
    static func wValleyGrey() -> UIColor {
        return UIColor(netHex: 0x676879)
    }
    
    static func wLightGrey() -> UIColor {
        return UIColor(netHex: 0xD8D8D8)
    }
    
    static func wLightGreyText() -> UIColor {
        return UIColor(netHex: 0x9698A3)
    }
    
    static func wBackgroundGrey() -> UIColor {
        return UIColor(netHex: 0xECECEC)
    }
    
    static func wDarkGreyBackground() -> UIColor {
        return UIColor(netHex: 0x282A32)
    }
    
    static func wLightGreyBackground() -> UIColor {
        return UIColor(netHex: 0xF1F1F1)
    }
    
    static func wSunny() -> UIColor {
        return UIColor(netHex: 0xFBBB13)
    }
    
    static func wEsmeral() -> UIColor {
        return UIColor(netHex: 0x38B87C)
    }
    
    static func wAirbnbPink() -> UIColor {
        return UIColor(netHex: 0xFA7476)
    }
    
    static func wTableHeaderErrorColor() -> UIColor {
        return UIColor(netHex: 0xF5464E)
    }
    
    static func wFadedWhiteColor() -> UIColor {
        return UIColor.white().withAlphaComponent(0.8)
    }
    
    static func wUnavailableTextColor() -> UIColor {
        return UIColor(white: 1, alpha: 0.4)
    }
    
    static func wUnavailableShapeColor() -> UIColor {
        return UIColor(netHex: 0x021521).withAlphaComponent(0.4)
    }
    
    static func wSelectedShapeColor() -> UIColor {
        return UIColor.white().withAlphaComponent(0.2)
    }
    
    static func wGreyColor() -> UIColor {
        return UIColor(red: 179.0/255.0, green: 179.0/255.0, blue: 188.0/255.0, alpha: 1.0)
    }
    
    static func wGreyTextColor() -> UIColor {
        return UIColor(netHex: 0x70747C)
    }
    
    static func wLightGreenColor() -> UIColor {
        return UIColor(netHex: 0x04AF82)
    }
    
    static func wCellSeparatorColor() -> UIColor {
        return UIColor(netHex: 0xCFCFCF).withAlphaComponent(0.5)
    }
}
