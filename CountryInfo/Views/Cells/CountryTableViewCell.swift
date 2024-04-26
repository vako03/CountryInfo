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
        label.numberOfLines = 0
        label.textColor = AppColors.customTextColor
        return label
    }()
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = AppColors.customTextColor
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
        backgroundColor = .clear
        contentView.backgroundColor = AppColors.customCellBackgroundColor
        
        contentView.layer.cornerRadius = 25
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = AppColors.customBackgroundColor1.cgColor
        contentView.layer.shadowOpacity = 0.0
        contentView.clipsToBounds = true
    }
    
    
    func configure(with country: Element) {
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

