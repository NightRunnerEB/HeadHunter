//
//  MainViewModel.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 28.05.2024.
//

import Foundation
import SwiftUI
import Alamofire

final class VacancyViewModel: ObservableObject {
    @Published var offers: [Offer] = []
    @Published var vacancies: [Vacancy] = []
    @Published var favoriteVacancyIDs: Set<String> = []
    @Published var favoriteVacancies: [Vacancy] = []
    
    init() {
        loadFavorites()
    }

    func fetchJobData() {
        let url = "https://run.mocky.io/v3/d67a278f-ddcb-438c-bf56-3194c529b12b"
        
        AF.request(url).responseDecodable(of: JobData.self) { response in
            switch response.result {
            case .success(let result):
                DispatchQueue.main.async { [self] in
                    self.offers = result.offers
                    self.vacancies = result.vacancies.map { vacancy in
                        var modifiedVacancy = vacancy
                        if self.favoriteVacancyIDs.contains(vacancy.id) || vacancy.isFavorite {
                            modifiedVacancy.isFavorite = true
                            self.favoriteVacancyIDs.insert(vacancy.id)
                        }
                        return modifiedVacancy
                    }
                    updateFavoriteVacancies()
                    saveFavorites()
                }
            case .failure(let error):
                print("Error decoding data: \(error)")
            }
        }
    }

    func toggleFavorite(vacancyID: String) {
        if let vacancy = vacancies.first(where: { $0.id == vacancyID }) {
            vacancy.isFavorite.toggle()
            if vacancy.isFavorite {
                favoriteVacancyIDs.insert(vacancyID)
            } else {
                favoriteVacancyIDs.remove(vacancyID)
            }
            updateFavoriteVacancies()
            saveFavorites()
        }
    }

    func updateFavoriteVacancies() {
        favoriteVacancies = vacancies.filter { $0.isFavorite }
    }

    func saveFavorites() {
        let ids = Array(favoriteVacancyIDs)
        UserDefaults.standard.set(ids, forKey: "favoriteVacancyIDs")
    }

    func loadFavorites() {
        if let ids = UserDefaults.standard.array(forKey: "favoriteVacancyIDs") as? [String] {
            favoriteVacancyIDs = Set(ids)
        }
    }
}
