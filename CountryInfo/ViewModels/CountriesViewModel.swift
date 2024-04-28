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
    private let networkService = NetworkService.shared
    
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
        networkService.fetchCountries { [weak self] result in
            switch result {
            case .success(let countries):
                self?.countries = countries
                self?.filteredCountries = countries
                DispatchQueue.main.async {
                    self?.delegate?.didUpdateCountries()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.delegate?.didEncounterError(error: error)
                }
            }
        }
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
