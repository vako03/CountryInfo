//
//  DetailCountryVC.swift
//  CountryInfo
//
//  Created by vako on 22.04.24.
//

import UIKit

class DetailCountryVC: UIViewController {
    
    var country: Country?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(flagImageView)
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 49),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flagImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 29),
            flagImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          
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
        }
    }
}
