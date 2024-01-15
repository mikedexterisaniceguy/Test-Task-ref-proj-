//
//  WeatherAlertView.swift
//  WeatherAlertApp
//
//  Created by Kiryl Maksimau on 11.01.24.
//

import SwiftUI

// MARK: - WeatherAlertView
struct WeatherAlertView: View {
    
    @ObservedObject var viewModel: WeatherAlertsViewModel = WeatherAlertsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.weatherAlerts.isEmpty {
                    ProgressView(Constants.loading)
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    let propertiesArray = viewModel.weatherAlerts.map { $0.properties }
                    AlertListView(alerts: propertiesArray)
                }
            }
            .navigationBarTitle(Constants.navTitle)
            .onAppear {
                viewModel.fetchWeatherAlerts()
            }
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherAlertView()
    }
}

// MARK: - Constants
extension WeatherAlertView {
    enum Constants {
        static let loading = "Loading Weather Alerts..."
        static let navTitle = "Weather Alerts"
    }
}
