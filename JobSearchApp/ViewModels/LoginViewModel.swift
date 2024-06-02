//
//  LoginViewModel.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 28.05.2024.
//

import Combine
import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var showError: Bool = false
    var coordinator: AppCoordinator

    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }

    func validateEmail() {
        if isValidEmail(email) {
            coordinator.showLoginCodeScreen(email: email)
        } else {
            showError = true
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
