//
//  DetailCountryViewModel.swift
//  CountryInfo
//
//  Created by vako on 26.04.24.
//

import Foundation

struct DetailCountryViewModel {
    let country: Element
    
    init(country: Element) {
        self.country = country
    }
    
    var flagImageURL: URL? {
        guard !country.flags.png.isEmpty, let url = URL(string: country.flags.png) else {
            return nil
        }
        return url
    }
    
    var aboutFlagText: String? {
        return country.flags.alt
    }
    
    var basicInfoLabels: [(String, String?)] {
        return [
            ("Capital", country.capital?.first),
            ("Region", country.region.rawValue),
            ("Neighbors", country.borders?.joined(separator: ", ") ?? ""),
            ("Car Driving Side", country.car.side.rawValue),
            ("Demonym (English)", country.demonyms?.eng.f),
            ("Area (km²)", "\(country.area)")
        ]
    }
    
    var googleMapsURL: URL? {
        return URL(string: country.maps.googleMaps)
    }
    
    var openStreetMapsURL: URL? {
        return URL(string: country.maps.openStreetMaps)
    }
}
