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

    static let wte = Color(hex: 0xFFFFFF)
    static let ppl = Color(hex: 0xE6E2FF)
    static let bl = Color(hex: 0x3E24FF)
    static let org = Color(hex: 0xFF9500)

    static let lGry = Color(hex: 0xD9D9D9)
    static let gry = Color(hex: 0x3C3C43)
    static let bck = Color(hex: 0x121212)


    static let skyBl = Color(hex: 0x007AFF)
    static let whtBl = Color(hex: 0xDFEFFF)


}
