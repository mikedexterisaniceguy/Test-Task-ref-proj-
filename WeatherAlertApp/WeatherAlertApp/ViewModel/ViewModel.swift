//
//  ViewModel.swift
//  WeatherAlertApp
//
//  Created by Kiryl Maksimau on 15.01.24.
//

import Foundation
import Combine

// MARK: - WeatherAlertsViewModel
final class WeatherAlertsViewModel: ObservableObject {
    @Published var weatherAlerts: [Feature] = []
    @Published var weatherAlertImages: [WeatherAlertImage] = []
    
    private var cancellables: Set<AnyCancellable> = []
}

//MARK: - WeatherAlertsViewModelInterface implementation
extension WeatherAlertsViewModel: WeatherAlertsViewModelInterface {
    func fetchWeatherAlerts() {
        NetworkService.shared.fetchWeatherAlerts { [weak self] result in
            switch result {
            case .success(let weatherData):
                DispatchQueue.main.async {
                    self?.weatherAlerts = weatherData.features
                }
            case .failure(let error):
                print("Ошибка при получении данных: \(error)")
            }
        }
    }
}
