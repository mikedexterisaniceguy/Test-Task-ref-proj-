//
//  JSONCodingKey.swift
//  WeatherAlertApp
//
//  Created by Kiryl Maksimau on 15.01.24.
//

import Foundation

// MARK: - JSONCodingKey
final class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}
