//
//  Extensions.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 31.05.2024.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func placeholderStyle(show: Bool, placeholder: String, color: Color) -> some View {
        self.modifier(PlaceholderStyle(show: show, placeholder: placeholder, color: color))
    }
}

extension Color {
    init(hex: String) {
        var hexString = hex
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        let scanner = Scanner(string: hexString)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
