//
//  Vacancy.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 01.06.2024.
//

import Foundation

class Vacancy: ObservableObject, Identifiable, Decodable {
    let id: String
    let title: String
    let address: Address
    let company: String
    let experience: Experience
    let salary: Salary
    let publishedDate: String
    let lookingNumber: Int?
    @Published var isFavorite: Bool
    let schedules: [String]
    let appliedNumber: Int?
    let description: String?
    let responsibilities: String
    let questions: [String]

    init(id: String, title: String, address: Address, company: String, experience: Experience, salary: Salary, publishedDate: String, lookingNumber: Int?, isFavorite: Bool, schedules: [String], appliedNumber: Int?, description: String?, responsibilities: String, questions: [String]) {
        self.id = id
        self.title = title
        self.address = address
        self.company = company
        self.experience = experience
        self.salary = salary
        self.publishedDate = publishedDate
        self.lookingNumber = lookingNumber
        self.isFavorite = isFavorite
        self.schedules = schedules
        self.appliedNumber = appliedNumber
        self.description = description
        self.responsibilities = responsibilities
        self.questions = questions
    }

    // Реализация Decodable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        address = try container.decode(Address.self, forKey: .address)
        company = try container.decode(String.self, forKey: .company)
        experience = try container.decode(Experience.self, forKey: .experience)
        salary = try container.decode(Salary.self, forKey: .salary)
        publishedDate = try container.decode(String.self, forKey: .publishedDate)
        lookingNumber = try container.decodeIfPresent(Int.self, forKey: .lookingNumber)
        isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
        schedules = try container.decode([String].self, forKey: .schedules)
        appliedNumber = try container.decodeIfPresent(Int.self, forKey: .appliedNumber)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        responsibilities = try container.decode(String.self, forKey: .responsibilities)
        questions = try container.decode([String].self, forKey: .questions)
    }

    enum CodingKeys: String, CodingKey {
        case id, title, address, company, experience, salary, publishedDate, lookingNumber, isFavorite, schedules, appliedNumber, description, responsibilities, questions
    }
}
