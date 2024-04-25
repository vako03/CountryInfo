//
//  CountriesViewModel.swift
//  CountryInfo
//
//  Created by vako on 25.04.24.
//

import Foundation
import UIKit

class CountriesViewModel {
    
     var countries: [Element] = []
     var filteredCountries: [Element] = []
    
    var numberOfCountries: Int {
        return filteredCountries.count
    }
    
    func country(at index: Int) -> Element? {
        guard index >= 0 && index < countries.count else {
            return nil
        }
        return countries[index]
    }
    
    
    
     func fetchData(completion: @escaping  (Error?) -> Void) {
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else {
            completion(NetworkError.invalidURL)
            return
        }
         
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
               completion(error)
                return
            }
            guard let data = data else {
                completion(NetworkError.noData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                self.countries = try decoder.decode([Element].self, from: data)
                self.filteredCountries = self.countries
                
                completion(nil)
            } catch {
                completion(error)
            }
        }.resume()
    }
}
