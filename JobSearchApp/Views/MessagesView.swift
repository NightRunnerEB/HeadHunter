//
//  MessagesView.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 28.05.2024.
//

import SwiftUI

struct MessagesView: View {
    @ObservedObject var viewModel: MessagesViewModel
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        Text("Сообщения")
            .font(.largeTitle)
            .padding()
    }
}
