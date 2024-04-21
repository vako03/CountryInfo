//
//  Country.swift
//  CountryInfo
//
//  Created by vako on 21.04.24.
//

import Foundation

// Model for Country data
struct Country: Codable {
    let name: Name
    let flags: Flags
}

struct Name: Codable {
    let common: String
}

struct Flags: Codable {
    let png: String
}
