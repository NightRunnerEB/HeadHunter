//
//  FavoritesView.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 28.05.2024.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: VacancyViewModel
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        VStack {
            Spacer()
            
            ScrollView {
            Group {
                Text("Избранное")
                    .font(.title1())
                
                Text("\(viewModel.favoriteVacancies.count) \(declineVacancies(count: viewModel.favoriteVacancies.count))")
                    .font(.title3())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
                ForEach(viewModel.favoriteVacancies, id: \.id) { vacancy in
                    VacancyCardView(vacancy: vacancy, viewModel: viewModel, coordinator: coordinator)
                }
            }
        }
        .foregroundStyle(.white)
    }

    func declineVacancies(count: Int) -> String {
        let lastDigit = count % 10
        let lastTwoDigits = count % 100
        
        if lastTwoDigits >= 11 && lastTwoDigits <= 14 {
            return "вакансий"
        } else {
            switch lastDigit {
            case 1:
                return "вакансия"
            case 2, 3, 4:
                return "вакансии"
            default:
                return "вакансий"
            }
        }
    }
}
