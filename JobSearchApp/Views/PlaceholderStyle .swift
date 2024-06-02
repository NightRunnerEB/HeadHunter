//
//  PlaceholderStyle .swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 31.05.2024.
//

import Foundation
import SwiftUI

struct PlaceholderStyle: ViewModifier {
    var show: Bool
    var placeholder: String
    var color: Color
    
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if show {
                Text(placeholder)
                    .font(.title3())
                    .foregroundColor(color)
            }
            content
                .foregroundColor(Color.white)
        }
    }
}
