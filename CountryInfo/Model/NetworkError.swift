//
//  NetworkError.swift
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
