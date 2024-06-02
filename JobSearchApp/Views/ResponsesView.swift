//
//  ResponsesView.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 28.05.2024.
//

import SwiftUI

struct ResponsesView: View {
    @ObservedObject var viewModel: ResponsesViewModel
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        Text("Отклики")
            .font(.largeTitle)
            .padding()
    }
}
