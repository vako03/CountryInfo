//
//  DetailCountryVC.swift
//  CountryInfo
//
//  Created by vako on 22.04.24.
//

import UIKit

class DetailCountryViewController: UIViewController {
    
    var country: Element?
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let basicInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Basic Information:"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let basicInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(flagImageView)
        view.addSubview(nameLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(basicInfoLabel)
        scrollView.addSubview(basicInfoStackView)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flagImageView.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 29),
            flagImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            scrollView.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            basicInfoLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            basicInfoLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            basicInfoLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            
            basicInfoStackView.topAnchor.constraint(equalTo: basicInfoLabel.bottomAnchor, constant: 10),
            basicInfoStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            basicInfoStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            basicInfoStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
        
        if let country = country {
            nameLabel.text = country.name.common
            
            if let flagURL = URL(string: country.flags.png) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: flagURL) {
                        DispatchQueue.main.async {
                            self.flagImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
            
            // Display basic information about the country
            let basicInfoLabels: [(String, String?)] = [
                ("Name", country.name.common),
                ("Top Level Domain", country.tld?.joined(separator: ", ")),
                ("Alpha-2 Code", country.cca2),
                ("Alpha-3 Code", country.cca3),
                ("Numeric Code", country.ccn3),
                ("International Olympic Committee Code", country.cioc),
                ("Independent", country.independent?.description),
                ("Status", country.status.rawValue),
                ("United Nations Membership", country.unMember.description),
                ("International Direct Dialing Prefix", country.idd.root),
                ("Capital Cities", country.capital?.joined(separator: ", ")),
                ("Alternate Spellings", country.altSpellings.joined(separator: ", ")),
                ("Region", country.region.rawValue),
                ("Subregion", country.subregion),
                ("Languages", country.languages?.values.joined(separator: ", ")),
                ("Latitude/Longitude", "\(country.latlng.first ?? 0), \(country.latlng.last ?? 0)"),
                ("Landlocked", country.landlocked.description),
                ("Borders", country.borders?.joined(separator: ", ")),
                ("Area (km²)", "\(country.area)"),
                ("Demonym (English)", country.demonyms?.eng.f),
                ("Flag", country.flag),
                ("Google Maps URL", country.maps.googleMaps),
                ("OpenStreetMaps URL", country.maps.openStreetMaps),
                ("Population", "\(country.population)"),
                ("Gini Coefficient", country.gini?.description),
                ("FIFA Code", country.fifa ?? "N/A"),
                ("Car Driving Side", country.car.side.rawValue),
                ("Timezones", country.timezones.joined(separator: ", ")),
                ("Continents", country.continents.map { $0.rawValue }.joined(separator: ", ")),
                ("Coat of Arms (PNG)", country.coatOfArms.png ?? "N/A"),
                ("Coat of Arms (SVG)", country.coatOfArms.svg ?? "N/A"),
                ("First Day of the Week", country.startOfWeek.rawValue),
                ("Postal Code Format", country.postalCode?.format ?? "N/A"),
                ("Postal Code Regex", country.postalCode?.regex ?? "N/A")
                // Add more labels for other properties as needed
            ]
            
            for (propertyName, propertyValue) in basicInfoLabels {
                let propertyLabel = UILabel()
                propertyLabel.translatesAutoresizingMaskIntoConstraints = false
                propertyLabel.text = "\(propertyName): \(propertyValue ?? "")"
                propertyLabel.font = UIFont.systemFont(ofSize: 16)
                propertyLabel.numberOfLines = 0
                basicInfoStackView.addArrangedSubview(propertyLabel)
            }
        }
    }
}
