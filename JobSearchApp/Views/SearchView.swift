//
//  MainView.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 28.05.2024.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: VacancyViewModel
    @ObservedObject var coordinator: AppCoordinator
    @State var search = ""
    
    var body: some View {
        VStack{
            
            Spacer()
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .padding(.trailing, 8)
                            
                            TextField("", text: $search)
                                .placeholderStyle(show: search.isEmpty, placeholder: "Должность, ключевые слова", color: CustomColors.grey3)
                        }
                        .font(.title4())
                        .padding(10)
                        .background(CustomColors.grey1)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Button(action: {}) {
                            Image(systemName: "slider.horizontal.3")
                        }
                        .padding(10)
                        .background(CustomColors.grey1)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(Array(viewModel.offers.enumerated()), id: \.element.id) { index, offer in
                                OfferView(offer: offer, id: index + 1)
                            }
                        }
                        .padding(.vertical, 15)
                    }
                    
                    Text("Вакансии для вас")
                        .font(.title2())
                    
                    // Список вакансий
                    ForEach(viewModel.vacancies.prefix(3)) { vacancy in
                        VacancyCardView(vacancy: vacancy, viewModel: viewModel, coordinator: coordinator)
                            .padding(.bottom, 5)
                    }
                    
                    if viewModel.vacancies.count > 3 {
                        Button(action: {
                            // логика раскрытия всего списка
                        }) {
                            Text("Еще \(viewModel.vacancies.count - 3) \(declineVacancies(count: viewModel.vacancies.count - 3))")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(CustomColors.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .padding(.top, 8)
                    }
                }
            }
            .padding(.horizontal, 12)
            .foregroundStyle(.white)
            .onAppear {
                // Обычно это условие выглядело бы глупым, но в нашем тестовом задании я всегда третий элемент получаю избранным, то есть даже если я его убрал из избранных и перезагрузил страницу, то получу его снова избранным. В общем, такое решение сделано только в рамках условий тестового задания
                if viewModel.vacancies.isEmpty {
                    viewModel.fetchJobData()
                }
            }
        }
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

struct OfferView: View {
    let offer: Offer
    let id: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Image("offer\(id)")
            
            Spacer()
            
            Text(offer.title)
            
            if let button = offer.button {
                Button(action: {}, label: {
                    Text(button.text)
                        .padding(.top, 1)
                        .foregroundStyle(CustomColors.green)
                })
            } else {
                Spacer()
            }
        }
        .font(.title4())
        .frame(maxWidth: 140, idealHeight: 100)
        .padding(.horizontal, 5)
        .padding(.vertical, 10)
        .background(CustomColors.grey1)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
