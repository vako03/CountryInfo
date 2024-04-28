//
//  NetworkService.swift
//  CountryInfo
//
//  Created by vako on 26.04.24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchCountries(completion: @escaping (Result<[Element], NetworkError>) -> Void) {
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.invalidURL))
                print("Error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let countries = try decoder.decode([Element].self, from: data)
                completion(.success(countries))
            } catch {
                completion(.failure(.decodingError))
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
