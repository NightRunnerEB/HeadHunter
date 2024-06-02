//
//  LoginCodeView.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 29.05.2024.
//

import SwiftUI

struct LoginCodeView: View {
    @ObservedObject var viewModel: LoginCodeViewModel
    @FocusState private var focusedField: Int?

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Отправили код на \(viewModel.email)")
                .foregroundStyle(.white)
                .font(.title2())
                .padding(.top, 100)
            
            Text("Напишите его, чтобы подтвердить, что это вы, а не кто-то другой входит в личный кабинет")
                .foregroundStyle(.white)
                .font(.title3())
            
            HStack(spacing: 10) {
                ForEach(0..<4, id: \.self) { index in
                    CustomTextField(text: $viewModel.code[index])
                        .focused($focusedField, equals: index)
                        .onChange(of: viewModel.code[index]) { _,newValue in
                            if newValue.count == 1 {
                                focusedField = index < 3 ? index + 1 : nil
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .onAppear {
                focusedField = 0
            }
            
            Button(action: {
                viewModel.validateCode()
            }) {
                Text("Подтвердить")
                    .font(.buttonText1())
                    .foregroundStyle(viewModel.isCodeComplete ? .white : CustomColors.grey5)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isCodeComplete ? CustomColors.blue : CustomColors.darkBlue)
                    .cornerRadius(8)
            }
            .disabled(!viewModel.isCodeComplete)
            
            Spacer()
        }
        .padding(.horizontal, 15)
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

struct CustomTextField: View {
    @Binding var text: String
    @FocusState var isFocused: Bool

    var body: some View {
        TextField("", text: $text)
            .placeholderStyle(show: !isFocused && text.isEmpty, placeholder: " *", color: CustomColors.grey3)
            .multilineTextAlignment(.center)
            .padding()
            .frame(width: 50, height: 50)
            .foregroundStyle(.white)
            .background(CustomColors.grey2)
            .cornerRadius(8)
            .keyboardType(.numberPad)
            .focused($isFocused)
            .onChange(of: text) { _,newValue in
                if newValue.count > 1 {
                    text = String(newValue.prefix(1))
                }
            }
    }
}

