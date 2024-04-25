//
//  CountriesViewModel.swift
//  CountryInfo
//
//  Created by vako on 25.04.24.
//
import Foundation

protocol CountriesViewModelDelegate: AnyObject {
    func didUpdateCountries()
    func didEncounterError(error: Error)
}

class CountriesViewModel {
    
    private var countries: [Element] = []
    private var filteredCountries: [Element] = []
    weak var delegate: CountriesViewModelDelegate?
    
    
    var numberOfCountries: Int {
        return filteredCountries.count
    }
    
    func country(at index: Int) -> Element? {
        guard index >= 0 && index < filteredCountries.count else {
            return nil
        }
        return filteredCountries[index]
    }
    
    func fetchData() {
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else {
            delegate?.didEncounterError(error: NetworkError.invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.delegate?.didEncounterError(error: error)
                return
            }
            guard let data = data else {
                self.delegate?.didEncounterError(error: NetworkError.noData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                self.countries = try decoder.decode([Element].self, from: data)
                self.filteredCountries = self.countries
                
                DispatchQueue.main.async {
                    self.delegate?.didUpdateCountries()
                }
            } catch {
                self.delegate?.didEncounterError(error: error)
            }
        }.resume()
    }
    
    func filterCountries(with searchText: String) {
        if searchText.isEmpty {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter {
                $0.name.common.lowercased().contains(searchText.lowercased())
            }
        }
        delegate?.didUpdateCountries()
    }
}
