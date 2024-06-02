//
//  ContentView.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 28.05.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator = AppCoordinator()

    var body: some View {
        VStack {
            if let currentView = coordinator.currentView {
                currentView
                    .background(Color.black)
            } else {
                EmptyView()
            }
            Spacer()
            CustomTabBar(tabViewModel: coordinator.tabViewModel, appCoordinator: coordinator, vacancyViewModel: coordinator.vacancyViewModel)
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.bottom)
    }
}
