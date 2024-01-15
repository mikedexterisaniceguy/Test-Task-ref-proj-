//
//  AlertListView.swift
//  WeatherAlertApp
//
//  Created by Kiryl Maksimau on 15.01.24.
//

import SwiftUI

// MARK: - AlertListView
struct AlertListView: View {
    let alerts: [Properties]
    
    var body: some View {
        List(alerts) { alert in
            let uniqueID = UUID().uuidString
            let imageModel = ImageModel(
                imageURL: URL(string: "https://picsum.photos/1000")!,
                uniqueID: uniqueID)
            AlertCellView(alert: alert, imageModel: imageModel)
        }
    }
}

// MARK: - Preview
struct AlertListView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleAlerts: [Properties] = [
            Properties(
                id: "sampleID1",
                type: .wxAlert,
                propertiesID: "sampleID1",
                areaDesc: "Sample Area 1",
                geocode: Geocode(
                    same: ["123456"],
                    ugc: ["UGC123"]),
                affectedZones: ["Sample Zone 1"],
                references: [],
                sent: Date(),
                effective: Date(),
                onset: Date(),
                expires: Date(),
                ends: Date(),
                status: .actual,
                messageType: .alert,
                category: .met,
                severity: .minor,
                certainty: .possible,
                urgency: .expected,
                event: "Sample Event 1",
                sender: .wNwsWebmasterNoaaGov,
                senderName: "Sample Sender 1",
                headline: "Sample Headline 1",
                description: "Sample Description 1",
                instruction: "Sample Instruction 1",
                response: .prepare,
                parameters: Parameters(
                    awipSidentifier: ["Sample AWIPS"],
                    wmOidentifier: ["Sample WMO"],
                    nwSheadline: ["Sample NWS Headline"],
                    blockchannel: [.eas],
                    easOrg: [.civ],
                    vtec: ["Sample VTEC"],
                    eventEndingTime: [Date()],
                    expiredReferences: ["Sample Expired"],
                    eventMotionDescription: ["Sample Motion"])
            )
        ]
        
        return AlertListView(alerts: sampleAlerts)
    }
}
