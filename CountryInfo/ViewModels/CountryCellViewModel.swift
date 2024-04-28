//
//  CountryCellViewModel.swift
//  CountryInfo
//
//  Created by vako on 28.04.24.
//

import UIKit

class CountryCellViewModel {
    let country: Element
    
    init(country: Element) {
        self.country = country
    }
    
    var name: String {
        return country.name.common
    }
    
    var flagURL: URL? {
        return URL(string: country.flags.png)
    }
}
