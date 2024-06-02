//
//  TabViewModel.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 28.05.2024.
//

import SwiftUI

final class TabViewModel: ObservableObject {
    @Published var selectedTab: Tab = .search

    enum Tab {
        case search
        case favorites
        case responses
        case messages
        case profile
    }
}
