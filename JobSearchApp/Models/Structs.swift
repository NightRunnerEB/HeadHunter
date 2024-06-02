//
//  Models.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 28.05.2024.
//

import Foundation

struct JobData: Decodable {
    let offers: [Offer]
    let vacancies: [Vacancy]
}

struct Offer: Identifiable, Decodable {
    let id: String?
    let title: String
    let button: OfferButton?
    let link: String
}

struct OfferButton: Decodable {
    let text: String
}

struct Address: Decodable {
    let town: String
    let street: String
    let house: String
    
    var fullAddress: String {
        return "\(town), \(street), \(house)"
    }
}

struct Experience: Decodable {
    let previewText: String
    let text: String
}

struct Salary: Decodable {
    let short: String?
    let full: String
}

