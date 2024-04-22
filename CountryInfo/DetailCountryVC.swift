//
//  DetailCountryVC.swift
//  CountryInfo
//
//  Created by vako on 22.04.24.
//

import UIKit

class DetailCountryViewController: UIViewController {
    
    var country: Element?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let aboutFlagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
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
    
    private let usefulLinksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Useful Links:"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let usefulLinksStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(flagImageView)
        contentView.addSubview(aboutFlagLabel)
        contentView.addSubview(basicInfoLabel)
        contentView.addSubview(basicInfoStackView)
        contentView.addSubview(usefulLinksLabel)
        contentView.addSubview(usefulLinksStackView)
        
        let line1 = createHorizontalLine()
        let line2 = createHorizontalLine()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            flagImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            flagImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            flagImageView.widthAnchor.constraint(equalToConstant: 200),
            flagImageView.heightAnchor.constraint(equalToConstant: 150),
            
            aboutFlagLabel.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 20),
            aboutFlagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            aboutFlagLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            basicInfoLabel.topAnchor.constraint(equalTo: aboutFlagLabel.bottomAnchor, constant: 20),
            basicInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            basicInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            basicInfoStackView.topAnchor.constraint(equalTo: basicInfoLabel.bottomAnchor, constant: 10),
            basicInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            basicInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            usefulLinksLabel.topAnchor.constraint(equalTo: basicInfoStackView.bottomAnchor, constant: 20),
            usefulLinksLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            usefulLinksLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            usefulLinksStackView.topAnchor.constraint(equalTo: usefulLinksLabel.bottomAnchor, constant: 10),
            usefulLinksStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            usefulLinksStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            usefulLinksStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            line1.topAnchor.constraint(equalTo: aboutFlagLabel.bottomAnchor, constant: 10),
            line1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            line1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line1.heightAnchor.constraint(equalToConstant: 1),
            
            line2.topAnchor.constraint(equalTo: basicInfoStackView.bottomAnchor, constant: 10),
            line2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            line2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line2.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        if let country = country {
            titleLabel.text = country.name.common
            
            if let flagURL = URL(string: country.flags.png) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: flagURL) {
                        DispatchQueue.main.async {
                            self.flagImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
            
            aboutFlagLabel.text = country.flags.alt
            
            let basicInfoLabels: [(String, String?)] = [
                ("Capital", country.capital?.first),
                ("Region", country.region.rawValue),
                ("Neighbors", country.borders?.joined(separator: ", ")),
                ("Car Driving Side", country.car.side.rawValue),
                ("Demonym (English)", country.demonyms?.eng.f),
                ("Area (km²)", "\(country.area)")
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
    
    private func createHorizontalLine() -> UIView {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0) // #D9D9D9
        view.addSubview(line)
        return line
    }
}
