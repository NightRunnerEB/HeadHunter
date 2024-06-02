//
//  AppCoordinator.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 28.05.2024.
//

import SwiftUI
import Combine

final class AppCoordinator: ObservableObject {
    @Published var currentView: AnyView?
    @Published var isLoggedIn: Bool = false
    var tabViewModel = TabViewModel()
    var vacancyViewModel = VacancyViewModel()
    private var cancellables = Set<AnyCancellable>()

    private var viewHistory: [AnyView] = []

    init() {
        setupBindings()
        showLogin()
        vacancyViewModel.loadFavorites()
    }

    private func setupBindings() {
        tabViewModel.$selectedTab
            .sink { [weak self] selectedTab in
                guard let self = self else { return }
                if self.isLoggedIn {
                    DispatchQueue.main.async {
                        self.navigate(to: selectedTab)
                    }
                }
            }
            .store(in: &cancellables)
    }

    private func showLogin() {
        DispatchQueue.main.async {
            let loginViewModel = LoginViewModel(coordinator: self)
            self.currentView = AnyView(LoginView(viewModel: loginViewModel))
            self.viewHistory = []
        }
    }

    func showMain() {
        DispatchQueue.main.async {
            self.isLoggedIn = true
            self.navigate(to: .search)
        }
    }

    func showLoginCodeScreen(email: String) {
        DispatchQueue.main.async {
            let loginCodeViewModel = LoginCodeViewModel(email: email, coordinator: self)
            self.currentView = AnyView(LoginCodeView(viewModel: loginCodeViewModel))
            self.viewHistory.append(self.currentView!)
        }
    }

    func showVacancyDetail(vacancy: Vacancy) {
        DispatchQueue.main.async {
            self.currentView = AnyView(VacancyDetailView(vacancy: vacancy, viewModel: self.vacancyViewModel, coordinator: self))
            self.viewHistory.append(self.currentView!)
        }
    }

    func goBack() {
        DispatchQueue.main.async {
            if self.viewHistory.count > 1 {
                self.viewHistory.removeLast()
                self.currentView = self.viewHistory.last
            }
        }
    }

    private func navigate(to tab: TabViewModel.Tab) {
        switch tab {
        case .search:
            currentView = AnyView(SearchView(viewModel: vacancyViewModel, coordinator: self))
        case .favorites:
            currentView = AnyView(FavoritesView(viewModel: vacancyViewModel, coordinator: self))
        case .responses:
            let viewModel = ResponsesViewModel()
            currentView = AnyView(ResponsesView(viewModel: viewModel, coordinator: self))
        case .messages:
            let viewModel = MessagesViewModel()
            currentView = AnyView(MessagesView(viewModel: viewModel, coordinator: self))
        case .profile:
            let viewModel = ProfileViewModel()
            currentView = AnyView(ProfileView(viewModel: viewModel, coordinator: self))
        }
        viewHistory.append(currentView!)
    }
}
