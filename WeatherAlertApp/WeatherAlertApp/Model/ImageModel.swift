//
//  ImageModel.swift
//  WeatherAlertApp
//
//  Created by Kiryl Maksimau on 15.01.24.
//

import Foundation

// MARK: - ImageModel
struct ImageModel {
    let imageURL: URL

    init(imageURL: URL, uniqueID: String) {
        var components = URLComponents(url: imageURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "uniqueID", value: uniqueID)]
        self.imageURL = components?.url ?? imageURL
    }
}

// MARK: - WeatherAlertImage
struct WeatherAlertImage {
    let featureID: String
    let imageURL: URL
}

