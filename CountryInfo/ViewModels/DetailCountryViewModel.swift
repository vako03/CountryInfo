//
//  DetailCountryViewModel.swift
//  CountryInfo
//
//  Created by vako on 26.04.24.
//

import Foundation

class DetailCountryViewModel {
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
        guard let mapsURLString = country.maps.openStreetMaps.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        return URL(string: mapsURLString)
    }
    
    var openStreetMapsURL: URL? {
        guard let mapsURLString = country.maps.googleMaps.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        return URL(string: mapsURLString)
    }
}
