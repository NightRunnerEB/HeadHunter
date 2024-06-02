//
//  VacancyCardView.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 28.05.2024.
//

import SwiftUI

struct VacancyCardView: View {
    @ObservedObject var vacancy: Vacancy
    @ObservedObject var viewModel: VacancyViewModel
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let lookingNumber = vacancy.lookingNumber {
                Text("Сейчас просматривает \(lookingNumber) \(declinePeople(count: lookingNumber))")
                    .foregroundColor(CustomColors.green)
                    .font(.text1())
            }
            HStack {
                Text(vacancy.title)
                    .font(.title3())
                
                Spacer()
                
                Button(action: {
                    viewModel.toggleFavorite(vacancyID: vacancy.id)
                }) {
                    Image(vacancy.isFavorite ? "heart-fill" : "heart-passive")
                }
            }
            Text(vacancy.address.town)
                .font(.text1())
            
            HStack {
                Text(vacancy.company)
                    .font(.text1())
                
                Image("check-mark")
            }
            
            HStack {
                Text("Опыт от \(vacancy.experience.previewText)")
                    .font(.text1())
                
                Image("experience")
            }
            
            Text("Опубликовано \(formatDate(vacancy.publishedDate))")
                .font(.text1())
                .foregroundStyle(CustomColors.grey3)
            
            Button("Откликнуться", action: {})
                .font(.buttonText2())
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(CustomColors.green)
                .foregroundColor(.white)
                .cornerRadius(50)
        }
        .padding()
        .foregroundStyle(.white)
        .background(CustomColors.grey1)
        .cornerRadius(8)
        .onTapGesture {
            coordinator.showVacancyDetail(vacancy: vacancy)
        }
    }
    
    private func declinePeople(count: Int) -> String {
        let lastDigit = count % 10
        let lastTwoDigits = count % 100
        
        if lastTwoDigits >= 11 && lastTwoDigits <= 14 {
            return "человек"
        } else {
            switch lastDigit {
            case 1:
                return "человек"
            case 2, 3, 4:
                return "человека"
            default:
                return "человек"
            }
        }
    }

    private func formatDate(_ dateString: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            guard let date = dateFormatter.date(from: dateString) else { return dateString }
            
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            let month = calendar.component(.month, from: date)
            
            let monthDeclension: String
            switch month {
            case 1: monthDeclension = "января"
            case 2: monthDeclension = "февраля"
            case 3: monthDeclension = "марта"
            case 4: monthDeclension = "апреля"
            case 5: monthDeclension = "мая"
            case 6: monthDeclension = "июня"
            case 7: monthDeclension = "июля"
            case 8: monthDeclension = "августа"
            case 9: monthDeclension = "сентября"
            case 10: monthDeclension = "октября"
            case 11: monthDeclension = "ноября"
            case 12: monthDeclension = "декабря"
            default: monthDeclension = ""
            }
            
            return "\(day) \(monthDeclension)"
        }
}
