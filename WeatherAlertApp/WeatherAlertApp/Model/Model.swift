//
//  Model.swift
//  WeatherAlertApp
//
//  Created by Kiryl Maksimau on 15.01.24.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let context: [ContextElement]
    let type: String
    let features: [Feature]
    let title: String
    let updated: Date

    enum CodingKeys: String, CodingKey {
        case context = "@context"
        case type, features, title, updated
    }
}

enum ContextElement: Codable {
    case contextClass(ContextClass)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(ContextClass.self) {
            self = .contextClass(x)
            return
        }
        throw DecodingError.typeMismatch(ContextElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ContextElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .contextClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ContextClass
struct ContextClass: Codable {
    let version: String
    let wx, vocab: String

    enum CodingKeys: String, CodingKey {
        case version = "@version"
        case wx
        case vocab = "@vocab"
    }
}

// MARK: - Feature
struct Feature: Codable, Identifiable {
    let id: String
    let type: FeatureType
    let geometry: Geometry?
    let properties: Properties
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: String
    let coordinates: [[[Double]]]
}

// MARK: - Properties
struct Properties: Codable, Identifiable {
    let id: String
    let type: TypeEnum
    let propertiesID, areaDesc: String
    let geocode: Geocode
    let affectedZones: [String]
    let references: [JSONAny]
    let sent, effective, onset, expires: Date
    let ends: Date?
    let status: Status
    let messageType: MessageType
    let category: Category
    let severity: Severity
    let certainty: Certainty
    let urgency: Urgency
    let event: String
    let sender: Sender
    let senderName, headline, description: String
    let instruction: String?
    let response: Response
    let parameters: Parameters

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case propertiesID = "id"
        case areaDesc, geocode, affectedZones, references, sent, effective, onset, expires, ends, status, messageType, category, severity, certainty, urgency, event, sender, senderName, headline, description, instruction, response, parameters
    }
}

enum Category: String, Codable {
    case met = "Met"
}

enum Certainty: String, Codable {
    case likely = "Likely"
    case observed = "Observed"
    case possible = "Possible"
    case unknown = "Unknown"
}

// MARK: - Geocode
struct Geocode: Codable {
    let same, ugc: [String]

    enum CodingKeys: String, CodingKey {
        case same = "SAME"
        case ugc = "UGC"
    }
}

enum MessageType: String, Codable {
    case alert = "Alert"
}

// MARK: - Parameters
struct Parameters: Codable {
    let awipSidentifier, wmOidentifier: [String]
    let nwSheadline: [String]?
    let blockchannel: [Blockchannel]
    let easOrg: [EASOrg]?
    let vtec: [String]?
    let eventEndingTime: [Date]?
    let expiredReferences, eventMotionDescription: [String]?

    enum CodingKeys: String, CodingKey {
        case awipSidentifier = "AWIPSidentifier"
        case wmOidentifier = "WMOidentifier"
        case nwSheadline = "NWSheadline"
        case blockchannel = "BLOCKCHANNEL"
        case easOrg = "EAS-ORG"
        case vtec = "VTEC"
        case eventEndingTime, expiredReferences, eventMotionDescription
    }
}

enum Blockchannel: String, Codable {
    case cmas = "CMAS"
    case eas = "EAS"
    case nwem = "NWEM"
}

enum EASOrg: String, Codable {
    case civ = "CIV"
    case wxr = "WXR"
}

enum Response: String, Codable {
    case allClear = "AllClear"
    case avoid = "Avoid"
    case execute = "Execute"
    case monitor = "Monitor"
    case prepare = "Prepare"
}

enum Sender: String, Codable {
    case wNwsWebmasterNoaaGov = "w-nws.webmaster@noaa.gov"
}

enum Severity: String, Codable {
    case minor = "Minor"
    case moderate = "Moderate"
    case severe = "Severe"
    case unknown = "Unknown"
}

enum Status: String, Codable {
    case actual = "Actual"
}

enum TypeEnum: String, Codable {
    case wxAlert = "wx:Alert"
}

enum Urgency: String, Codable {
    case expected = "Expected"
    case future = "Future"
    case immediate = "Immediate"
    case past = "Past"
    case unknown = "Unknown"
}

enum FeatureType: String, Codable {
    case feature = "Feature"
}
