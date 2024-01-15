//
//  NetworkService.swift
//  WeatherAlertApp
//
//  Created by Kiryl Maksimau on 15.01.24.
//

import Foundation

// MARK: - NetworkService
final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
}

// MARK: - NetworkServiceInterface implementation
extension NetworkService: NetworkServiceInterface {
    func fetchWeatherAlerts(completion: @escaping (Result<Welcome, NetworkError>) -> Void) {
        let endpoint = Constants.alertsEndpoint
            
            guard let url = URL(string: endpoint) else {
                completion(.failure(.invalidURL))
                return
            }
            
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(.invalidURL))
                    print("Ошибка: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    print("Данные не получены")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let weatherData = try decoder.decode(Welcome.self, from: data)
                    completion(.success(weatherData))
                } catch {
                    completion(.failure(.decodingError))
                    print("Ошибка декодирования JSON: \(error.localizedDescription)")
                    print("Данные JSON: \(String(data: data, encoding: .utf8) ?? "Не удается прочитать данные JSON")")
                }
            }
            
            task.resume()
    }
}

// MARK: - Constants
extension NetworkService {
    enum Constants {
        static let alertsEndpoint = "https://api.weather.gov/alerts/active?status=actual&message_type=alert"
    }
}
