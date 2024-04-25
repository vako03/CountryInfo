//
//  Country.swift
//  CountryInfo
//
//  Created by vako on 21.04.24.
//

// CountryModels.swift

import Foundation

    // MARK: - Element
    struct Element: Codable {
        let name: Name
        let capital: [String]?
        let region: Region
        let subregion: String?
        let languages: [String: String]?
        let borders: [String]?
        let area: Double
        let demonyms: Demonyms?
        let flag: String
        let maps: Maps
        let population: Int
        let car: Car
        let continents: [Continent]
        let flags: Flags
    }

    // MARK: - CapitalInfo
    struct CapitalInfo: Codable {
        let latlng: [Double]?
    }

    // MARK: - Car
    struct Car: Codable {
        let signs: [String]?
        let side: Side
    }

    enum Side: String, Codable {
        case sideLeft = "left"
        case sideRight = "right"
    }

    // MARK: - CoatOfArms
    struct CoatOfArms: Codable {
        let png: String?
        let svg: String?
    }

    enum Continent: String, Codable {
        case africa = "Africa"
        case antarctica = "Antarctica"
        case asia = "Asia"
        case europe = "Europe"
        case northAmerica = "North America"
        case oceania = "Oceania"
        case southAmerica = "South America"
    }

    // MARK: - Demonyms
    struct Demonyms: Codable {
        let eng: Eng
        let fra: Eng?
    }

    // MARK: - Eng
    struct Eng: Codable {
        let f, m: String
    }

    // MARK: - Flags
    struct Flags: Codable {
        let png: String
        let svg: String
        let alt: String?
    }

    // MARK: - Idd
    struct Idd: Codable {
        let root: String?
        let suffixes: [String]?
    }

    // MARK: - Maps
    struct Maps: Codable {
        let googleMaps, openStreetMaps: String
    }

    // MARK: - Name
    struct Name: Codable {
        let common, official: String
        let nativeName: [String: Translation]?
    }

    // MARK: - Translation
    struct Translation: Codable {
        let official, common: String
    }

    enum Region: String, Codable {
        case africa = "Africa"
        case americas = "Americas"
        case antarctic = "Antarctic"
        case asia = "Asia"
        case europe = "Europe"
        case oceania = "Oceania"
    }
 

enum NetworkError: Error {
    case invalidURL
    case  noData
    case decodingError
}
