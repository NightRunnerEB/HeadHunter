//
//  CustomTabBar.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 28.05.2024.
//

import SwiftUI

struct CustomTabBar: View {
    @ObservedObject var tabViewModel: TabViewModel
    @ObservedObject var appCoordinator: AppCoordinator
    @ObservedObject var vacancyViewModel: VacancyViewModel
    
    var body: some View {
        HStack(alignment: .bottom) {
            Spacer()
            tabButton(icon: "lupa", tab: .search, title: "Поиск")
            Spacer()
            tabButtonWithBadge(icon: "heart", tab: .favorites, title: "Избранное", badgeCount: vacancyViewModel.favoriteVacancies.count)
            Spacer()
            tabButton(icon: "message", tab: .responses, title: "Отклики")
            Spacer()
            tabButton(icon: "social", tab: .messages, title: "Сообщения")
            Spacer()
            tabButton(icon: "profile", tab: .profile, title: "Профиль")
            Spacer()
        }
        .padding(.bottom, 15)
        .frame(height: 65)
        .overlay(
            Rectangle()
                .frame(height: 0.45)
                .foregroundStyle(CustomColors.grey3),
            alignment: .top
        )
    }
    
    private func tabButton(icon: String, tab: TabViewModel.Tab, title: String) -> some View {
        Button(action: {
            if appCoordinator.isLoggedIn {
                tabViewModel.selectedTab = tab
            }
        }) {
            VStack {
                Image("\(icon)-\(tabViewModel.selectedTab == tab ? "active" : "passive")")
                
                Text(title)
                    .foregroundColor(tabViewModel.selectedTab == tab ? CustomColors.blue : CustomColors.grey4)
                    .font(.tabText())
            }
        }
        .disabled(!appCoordinator.isLoggedIn)
    }
    
    private func tabButtonWithBadge(icon: String, tab: TabViewModel.Tab, title: String, badgeCount: Int) -> some View {
        Button(action: {
            if appCoordinator.isLoggedIn {
                tabViewModel.selectedTab = tab
            }
        }) {
            VStack {
                ZStack {
                    Image(systemName: "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    
                    if vacancyViewModel.favoriteVacancyIDs.count > 0 {
                        Text("\(badgeCount)")
                            .font(.numberText())
                            .foregroundStyle(.white)
                            .padding(4)
                            .background(CustomColors.red)
                            .clipShape(Circle())
                            .offset(x: 9, y: -6)
                    }
                }
                
                Text(title)
                    .font(.tabText())
            }
            .foregroundStyle(tabViewModel.selectedTab == tab ? CustomColors.blue : CustomColors.grey4)
        }
        .disabled(!appCoordinator.isLoggedIn)
    }
}
