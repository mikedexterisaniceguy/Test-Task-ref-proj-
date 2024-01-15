//
//  AlertCellView.swift
//  WeatherAlertApp
//
//  Created by Kiryl Maksimau on 15.01.24.
//

import SwiftUI
import SDWebImageSwiftUI

// MARK: - AlertCell
struct AlertCellView: View {
    let alert: Properties
    let imageModel: ImageModel
    let dateFormatter: DateUtilites = DateUtilites.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            WebImage(url: imageModel.imageURL)
                .resizable()
                .placeholder {
                    Color.gray
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(height: 200)
                .clipped()
            
            Text("Event: \(alert.event)")
                .font(.headline)
            Text("Start Date: \(dateFormatter.formattedDate(alert.effective))")
            Text("End Date: \(dateFormatter.formattedDate(alert.ends ?? Date()))")
            Text("Source: \(alert.senderName)")
            Text("Duration: \(dateFormatter.calculateDuration(alert.effective, alert.ends))")
        }
        .padding()
    }
}

// MARK: - Preview
struct AlertCellView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleAlert = Properties(
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
        
        let sampleImageModel = ImageModel(
            imageURL: URL(string: "https://picsum.photos/1000")!,
            uniqueID: "uniqueID")
        
        return AlertCellView(alert: sampleAlert, imageModel: sampleImageModel)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
