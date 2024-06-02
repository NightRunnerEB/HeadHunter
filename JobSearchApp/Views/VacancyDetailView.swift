//
//  VacancyDetailView.swift
//  JobSearchApp
//
//  Created by Евгений Бухарев on 29.05.2024.
//

import UIKit
import MapKit
import SwiftUI

struct VacancyDetailView: View {
    var vacancy: Vacancy
    @ObservedObject var viewModel: VacancyViewModel
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        VStack{
            
            Spacer()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    
                    HStack {
                        Button(action: {
                            coordinator.goBack()
                        }, label: {
                            // Мне удалили дизайн в Figma, поэтому тут немного другая иконка
                            Image(systemName: "chevron.left")
                        })
                        
                        Spacer()
                        
                        HStack {
                            Button(action: {
                                viewModel.toggleFavorite(vacancyID: vacancy.id)
                            }, label: {
                                Image(vacancy.isFavorite ? "heart-fill" : "heart-passive")
                            })
                        }
                    }
                    
                    Text(vacancy.title)
                        .font(.title1())
                    
                    Text(vacancy.salary.full)
                        .font(.title3())
                    
                    Text("Требуемый опыт: \(vacancy.experience.text)")
                        .font(.title4())
                    
                    if !vacancy.schedules.isEmpty {
                        Text(vacancy.schedules.map { $0.capitalized }.joined(separator: ", "))
                            .font(.title4())
                    }
                    
                    HStack {
                        
                        if let appliedNumber = vacancy.appliedNumber {
                            Spacer()
                            
                            HStack {
                                
                                Text("\(appliedNumber) \(appliedNumber == 1 ? "человек" : "человека") уже откликнулось")
                                    .font(.title3())
                                    .cornerRadius(8)
                                
                                Image("responded")
                                    .offset(x: -3, y: -10)
                            }
                            .padding(6)
                            .background(CustomColors.green)
                            .cornerRadius(10)
                            
                            Spacer()
                        }
                        
                        if let lookingNumber = vacancy.lookingNumber {
                            HStack {
                                Text("\(lookingNumber) \(lookingNumber == 1 ? "человек" : "человека") сейчас смотрят")
                                    .font(.title3())
                                    .cornerRadius(8)
                                
                                Image("watching")
                                    .offset(x: -3, y: -10)
                            }
                            .padding(6)
                            .background(CustomColors.green)
                            .cornerRadius(10)
                        }
                        
                        Spacer()
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(vacancy.company)
                                .font(.title3())
                            Image("check-mark")
                        }
                        
                        MapView(address: vacancy.address.fullAddress)
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Text("\(vacancy.address.town), \(vacancy.address.street), \(vacancy.address.house)")
                            .font(.body)
                    }
                    .padding()
                    .background(CustomColors.grey1)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    if let description = vacancy.description {
                        Text(description)
                            .font(.body)
                    }
                    
                    Text("Ваши задачи")
                        .font(.title2())
                        .padding(.top)
                    
                    Text(vacancy.responsibilities.replacingOccurrences(of: "\\n", with: "\n"))
                        .font(.body)
                    
                    Text("Задайте вопрос работодателю")
                        .font(.title2())
                        .padding(.top)
                    
                    Text("Он получит его с откликом на вакансию")
                        .font(.body)
                        .padding(.bottom)
                    
                    ForEach(vacancy.questions, id: \.self) { question in
                        Text(question)
                            .font(.body)
                            .padding(.vertical, 5)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        // Логика для кнопки откликнуться
                    }) {
                        Text("Откликнуться")
                            .font(.title3())
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                }
                .foregroundStyle(.white)
                .padding()
            }
        }
    }
}

struct MapView: UIViewRepresentable {
    var address: String
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemarks = placemarks, let placemark = placemarks.first {
                let coordinate = placemark.location!.coordinate
                let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                uiView.setRegion(region, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = address
                uiView.addAnnotation(annotation)
            }
        }
    }
}

