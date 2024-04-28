//
//  DetailCountryViewController.swift
//  CountryInfo
//
//  Created by vako on 22.04.24.
//

import UIKit
import SafariServices

class DetailCountryViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: DetailCountryViewModel?
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.tintColor = AppColors.customBackgroundColor1
        return backButton
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = PropertiesSetup.setupView(backgroundColor: AppColors.customBackgroundColor)
        return view
    }()
    
    private let imageContainerView: UIView = {
        let view = PropertiesSetup.setupView(backgroundColor: .clear)
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.masksToBounds = false
        return view
    }()
    
    private let flagImageView: UIImageView = {
        let imageView = PropertiesSetup.setupImageView(contentMode: .scaleToFill)
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let aboutFlagInfo : UILabel = {
        let label = PropertiesSetup.setupLabel(text: "About the flag:")
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let aboutFlagLabel: UILabel = {
        let label = PropertiesSetup.setupLabel(text: "")
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let basicInfoLabel: UILabel = {
        let label = PropertiesSetup.setupLabel(text: "Basic Information:")
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let basicInfoStackView: UIStackView = {
        let stackView = PropertiesSetup.setupStackView(axis: .vertical, spacing: 10)
        return stackView
    }()
    
    private let usefulLinksLabel: UILabel = {
        let label = PropertiesSetup.setupLabel(text: "Useful Links:")
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let usefulLinksStackView: UIStackView = {
        let stackView = PropertiesSetup.setupStackView(axis: .vertical, spacing: 10)
        return stackView
    }()
    
    private lazy var googleMapsButton: UIButton = {
        let button = PropertiesSetup.setupButton(title: "", backgroundColor: .clear)
        button.addTarget(self, action: #selector(openGoogleMaps), for: .touchUpInside)
        button.setImage(UIImage(named: "Group1"), for: .normal)
        return button
    }()
    
    private lazy var openStreetMapsButton: UIButton = {
        let button = PropertiesSetup.setupButton(title: "", backgroundColor: .clear)
        button.addTarget(self, action: #selector(openOpenStreetMaps), for: .touchUpInside)
        button.setImage(UIImage(named: "Group2"), for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - View Setup
    
    private func setupViews() {
        view.backgroundColor = AppColors.customBackgroundColor
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imageContainerView)
        imageContainerView.addSubview(flagImageView)
        contentView.addSubview(aboutFlagInfo)
        contentView.addSubview(aboutFlagLabel)
        contentView.addSubview(basicInfoLabel)
        contentView.addSubview(basicInfoStackView)
        contentView.addSubview(usefulLinksLabel)
        contentView.addSubview(usefulLinksStackView)
        contentView.addSubview(googleMapsButton)
        contentView.addSubview(openStreetMapsButton)
        
        let line1 = PropertiesSetup.createHorizontalLine()
        let line2 = PropertiesSetup.createHorizontalLine()
        
        contentView.addSubview(line1)
        contentView.addSubview(line2)
        
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
            
            imageContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 29),
            imageContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageContainerView.heightAnchor.constraint(equalToConstant: 228),
            
            flagImageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            flagImageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
            flagImageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
            flagImageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),
            
            aboutFlagInfo.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 25),
            aboutFlagInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            aboutFlagLabel.topAnchor.constraint(equalTo: aboutFlagInfo.bottomAnchor, constant: 15),
            aboutFlagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            aboutFlagLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            line1.topAnchor.constraint(equalTo: aboutFlagLabel.bottomAnchor, constant: 20),
            line1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            line1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            line1.heightAnchor.constraint(equalToConstant: 2),
            
            basicInfoLabel.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 24),
            basicInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            basicInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            basicInfoStackView.topAnchor.constraint(equalTo: basicInfoLabel.bottomAnchor, constant: 10),
            basicInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            basicInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            line2.topAnchor.constraint(equalTo: basicInfoStackView.bottomAnchor, constant: 20),
            line2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            line2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            line2.heightAnchor.constraint(equalToConstant: 2),
            
            usefulLinksLabel.topAnchor.constraint(equalTo: line2.bottomAnchor, constant: 25),
            usefulLinksLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            usefulLinksLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            usefulLinksStackView.topAnchor.constraint(equalTo: usefulLinksLabel.bottomAnchor, constant: 10),
            usefulLinksStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            usefulLinksStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            googleMapsButton.topAnchor.constraint(equalTo: usefulLinksStackView.bottomAnchor, constant: 15),
            googleMapsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 94),
            
            openStreetMapsButton.topAnchor.constraint(equalTo: usefulLinksStackView.bottomAnchor, constant: 15),
            openStreetMapsButton.leadingAnchor.constraint(equalTo: googleMapsButton.trailingAnchor, constant: 87),
            openStreetMapsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -94),
            
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: openStreetMapsButton.bottomAnchor, constant: 25)
        ])
        
        if let viewModel = viewModel {
            if let flagImageURL = viewModel.flagImageURL {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: flagImageURL) {
                        DispatchQueue.main.async {
                            self.flagImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
            
            aboutFlagLabel.text = viewModel.aboutFlagText
            
            for (propertyName, propertyValue) in viewModel.basicInfoLabels {
                let horizontalStackView = PropertiesSetup.setupStackView(axis: .horizontal, spacing: 10)
                
                let propertyLabel = PropertiesSetup.setupLabel(text: propertyName)
                let valueLabel = PropertiesSetup.setupLabel(text: propertyValue ?? "")
                
                horizontalStackView.addArrangedSubview(propertyLabel)
                horizontalStackView.addArrangedSubview(valueLabel)
                
                self.basicInfoStackView.addArrangedSubview(horizontalStackView)
            }
        }
        
        setupNavigationBar()
    }
    
    // MARK: - Navigation Bar
    
    private func setupNavigationBar() {
        if let viewModel = viewModel {
            setupNavigationBar(withTitle: viewModel.country.name.common)
        }
    }
    
    // MARK: - Actions
    
    @objc private func openGoogleMaps() {
        guard let viewModel = viewModel,
              let url = viewModel.googleMapsURL else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    @objc private func openOpenStreetMaps() {
        guard let viewModel = viewModel,
              let url = viewModel.openStreetMapsURL else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
