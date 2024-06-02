//
//  FontExtension.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 31.05.2024.
//

import Foundation
import SwiftUI

extension Font {
    static let sfProDisplay = "SF-Pro-Display"

    static func title1() -> Font {
        return .custom("\(sfProDisplay)-Semibold", size: 22)
    }

    static func title2() -> Font {
        return .custom("\(sfProDisplay)-Semibold", size: 20)
    }

    static func title3() -> Font {
        return .custom("\(sfProDisplay)-Medium", size: 16)
    }

    static func title4() -> Font {
        return .custom("\(sfProDisplay)-Medium", size: 14)
    }

    static func text1() -> Font {
        return .custom("\(sfProDisplay)-Regular", size: 14)
    }

    static func buttonText1() -> Font {
        return .custom("\(sfProDisplay)-Semibold", size: 16)
    }

    static func buttonText2() -> Font {
        return .custom("\(sfProDisplay)-Regular", size: 14)
    }

    static func tabText() -> Font {
        return .custom("\(sfProDisplay)-Regular", size: 10)
    }

    static func numberText() -> Font {
        return .custom("\(sfProDisplay)-Regular", size: 10)
    }
}

