//
//  ProfileView.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 28.05.2024.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        Text("Профиль")
            .font(.title1())
            .padding()
    }
}
