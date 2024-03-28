//
//  AppTheme.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/6/24.
//

import Foundation
import SwiftUI

struct AppTheme {
    @Environment(\.colorScheme) var colorScheme
    
    static let primary = UIColor(red: 0/255, green: 191/255, blue: 178/255, alpha: 1.0)
    static var button: Color {
        Color(UIColor { traits in
            switch traits.userInterfaceStyle {
            case .dark:
                return UIColor.black
            default:
                return UIColor.white
            }
        })
    }
    static var buttonText = UIColor(red: 41/255, green: 41/255, blue: 41/255, alpha: 1.0)
    
    static var text: Color {
        Color(UIColor { traits in
            switch traits.userInterfaceStyle {
            case .dark:
                return UIColor.white
            default:
                return UIColor(red: 41/255, green: 41/255, blue: 41/255, alpha: 1.0)
            }
        })
    }
    
}

extension Color {
  init(hex: String) {
    var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
    if hexValue.hasPrefix("#") {
      hexValue.remove(at: hexValue.startIndex)
    }
    var rgbValue: UInt64 = 0
    Scanner(string: hexValue).scanHexInt64(&rgbValue)
    let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
    let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
    self.init(red: red, green: green, blue: blue)
  }
}
