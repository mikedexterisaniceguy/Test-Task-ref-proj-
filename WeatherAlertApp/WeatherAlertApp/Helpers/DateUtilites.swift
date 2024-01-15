//
//  DateUtilites.swift
//  WeatherAlertApp
//
//  Created by Kiryl Maksimau on 15.01.24.
//

import Foundation

// MARK: - DateUtilites
final class DateUtilites {
    static let shared = DateUtilites()
    
    let dateFormatter: DateFormatter

    private init(dateFormatter: DateFormatter = DateFormatter()) {
        self.dateFormatter = dateFormatter
    }

    func formattedDate(_ date: Date) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }

    func calculateDuration(_ startDate: Date, _ endDate: Date?) -> String {
        guard let endDate = endDate else { return "Unknown" }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: startDate, to: endDate)

        if let hours = components.hour, let minutes = components.minute {
            return "\(hours)h \(minutes)m"
        } else {
            return "Unknown"
        }
    }
}
