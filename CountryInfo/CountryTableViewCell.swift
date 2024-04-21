//
//  CountryTableViewCell.swift
//  CountryInfo
//
//  Created by vako on 21.04.24.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(flagImageView)
        contentView.addSubview(arrowImageView)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            
            
            flagImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            flagImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            flagImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            flagImageView.heightAnchor.constraint(equalToConstant: 20),
            flagImageView.widthAnchor.constraint(equalToConstant: 30),


            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.heightAnchor.constraint(equalToConstant: 12),
            arrowImageView.widthAnchor.constraint(equalToConstant: 12),
            
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
        
        // Cell styling
        contentView.backgroundColor = .white // Cell background color
        contentView.layer.cornerRadius = 15 // Rounded corners
        contentView.layer.borderWidth = 1 // Border width
        contentView.layer.borderColor = UIColor.black.cgColor // Border color
        contentView.clipsToBounds = true // Clip subviews to rounded corners
    }
    
    // Configure cell with country data
    func configure(with country: Country) {
        nameLabel.text = country.name.common
        
        // Load flag image asynchronously
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
