//
//  LoginView.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 28.05.2024.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            LoginHeaderView()
            
            Spacer()
            
            UserLoginView(email: $viewModel.email, validateEmail: viewModel.validateEmail, showError: $viewModel.showError)
            
            EmployerLoginView()
            
            Spacer()
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

struct UserLoginView: View {
    @Binding var email: String
    var validateEmail: () -> Void
    @Binding var showError: Bool
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Поиск работы")
                .font(.title3())
                .foregroundStyle(.white)
            
            HStack {
                if !isFocused && email.isEmpty {
                    Image(systemName: "envelope")
                }
                
                TextField("", text: $email, onEditingChanged: { editing in
                    showError = false
                    isFocused = editing
                })
                .keyboardType(.emailAddress)
                .font(.title3())
                .focused($isFocused)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .placeholderStyle(show: email.isEmpty, placeholder: "Электронная почта", color: CustomColors.grey3)
                
                if !email.isEmpty {
                    Button(action: {
                        email = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                }
            }
            .foregroundStyle(.white)
            .padding()
            .background(CustomColors.grey2)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(showError ? CustomColors.red : Color.clear, lineWidth: 2)
            )
            
            if showError {
                Text("Вы ввели неверный e-mail")
                    .foregroundColor(CustomColors.red)
                    .font(.caption)
            }
            
            HStack {
                Button(action: {
                    validateEmail()
                }) {
                    Text("Продолжить")
                        .font(.buttonText2())
                        .foregroundColor(email.isEmpty ? CustomColors.grey5 : .white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(email.isEmpty ? CustomColors.darkBlue : CustomColors.blue)
                        .cornerRadius(8)
                }
                .disabled(email.isEmpty)
                
                Button(action: {
                    // Действие для кнопки "Войти с паролем"
                }) {
                    Text("Войти с паролем")
                        .font(.buttonText2())
                        .foregroundColor(CustomColors.darkBlue)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
        }
        .padding()
        .background(CustomColors.grey1)
        .cornerRadius(8)
        .padding(.horizontal)
    }
}


struct LoginHeaderView: View {
    var body: some View {
        Text("Вход в личный кабинет")
            .foregroundColor(.white)
            .font(.title2())
            .padding(.top, 50)
    }
}

struct EmployerLoginView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            Text("Поиск сотрудников")
                .font(.title3())
            
            Text("Размещение вакансий и доступ к базе резюме")
                .font(.text1())
            
            Button(action: {
                // Действие для кнопки "Я ищу сотрудников"
            }) {
                Text("Я ищу сотрудников")
                    .font(.buttonText2())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(CustomColors.green)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
            }
        }
        .padding()
        .foregroundColor(.white)
        .background(CustomColors.grey1)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal)
    }
}
