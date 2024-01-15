//
//  NetworkError.swift
//  WeatherAlertApp
//
//  Created by Kiryl Maksimau on 15.01.24.
//

import Foundation

// MARK: - NetworkError
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
