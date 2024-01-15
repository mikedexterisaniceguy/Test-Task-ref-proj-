//
//  NetworkServiceInterface.swift
//  WeatherAlertApp
//
//  Created by Kiryl Maksimau on 15.01.24.
//

import Foundation

// MARK: - NetworkServiceInterface
protocol NetworkServiceInterface {
    func fetchWeatherAlerts(completion: @escaping (Result<Welcome, NetworkError>) -> Void)
}
