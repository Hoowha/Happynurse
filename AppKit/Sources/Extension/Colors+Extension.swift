//
//  Colors+Extension.swift
//  WhisperBoardKit
//
//  Created by jose Yun on 2023/09/03.
//


import Foundation
import SwiftUI

extension Color {
    init(hex: UInt) {
            let red = Double((hex >> 16) & 0xff) / 255.0
            let green = Double((hex >> 8) & 0xff) / 255.0
            let blue = Double(hex & 0xff) / 255.0
      self.init(red: red, green: green, blue: blue, opacity: 1.0)
    }

    static let background = Color(hex: 0xF2F4F6)

    static let white = Color(hex: 0xFFFFFF)
    static let purple = Color(hex: 0xE6E2FF)
    static let blue = Color(hex: 0x3E24FF)
    static let orange = Color(hex: 0xFF9500)

    static let lightGrey = Color(hex: 0xD9D9D9)
    static let grey = Color(hex: 0x3C3C43)
    static let black = Color(hex: 0x121212)


    static let skyBlue = Color(hex: 0x007AFF)
    static let whiteBlue = Color(hex: 0xDFEFFF)

}
