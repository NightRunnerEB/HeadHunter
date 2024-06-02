//
//  LoginCodeViewModel.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 29.05.2024.
//

import Combine
import SwiftUI
import Foundation

final class LoginCodeViewModel: ObservableObject {
    @Published var email: String
    @Published var code: [String] = ["", "", "", ""]
    @Published var isCodeComplete: Bool = false
    var coordinator: AppCoordinator

    private var cancellables = Set<AnyCancellable>()

    init(email: String, coordinator: AppCoordinator) {
        self.coordinator = coordinator
        self.email = email

        $code
            .map { $0.joined().count == 4 }
            .assign(to: \.isCodeComplete, on: self)
            .store(in: &cancellables)
    }

    func validateCode() {
        // Здесь логика проверки кода
        coordinator.showMain()
    }
}
