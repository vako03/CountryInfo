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
    
    var country: Element?
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.tintColor = .black
        return backButton
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor =  AppColors.customBackgroundColor
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white //secondarySystemBackground
        return contentView
    }()
    
    let imageContainerView: UIView = {
        let imageContainerView = UIView()
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.layer.cornerRadius = 15
        imageContainerView.layer.shadowColor = UIColor.black.cgColor
        imageContainerView.layer.shadowRadius = 2
        imageContainerView.layer.shadowOpacity = 0.5
        imageContainerView.layer.shadowOffset = CGSize(width: 0, height: 5)
        imageContainerView.layer.masksToBounds = false
        return imageContainerView
    }()
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let aboutFlagInfo : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "About the flag:"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let aboutFlagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
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
    
    private lazy var googleMapsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openGoogleMaps), for: .touchUpInside)
        button.setImage(UIImage(named: "Group1"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var openStreetMapsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openOpenStreetMaps), for: .touchUpInside)
        button.setImage(UIImage(named: "Group2"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.customBackgroundColor
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageContainerView)
        imageContainerView.addSubview(flagImageView)
        contentView.backgroundColor =  AppColors.customBackgroundColor
        
        contentView.addSubview(aboutFlagInfo)
        contentView.addSubview(aboutFlagLabel)
        contentView.addSubview(basicInfoLabel)
        contentView.addSubview(basicInfoStackView)
        contentView.addSubview(usefulLinksLabel)
        contentView.addSubview(usefulLinksStackView)
        contentView.addSubview(googleMapsButton)
        contentView.addSubview(openStreetMapsButton)
        
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
            
        ])
        
        if let country = country {
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
                let horizontalStackView = UIStackView()
                horizontalStackView.axis = .horizontal
                horizontalStackView.spacing = 10
                horizontalStackView.alignment = .fill
                horizontalStackView.distribution = .fill
                
                let propertyLabel = UILabel()
                propertyLabel.text = propertyName
                propertyLabel.font = UIFont.systemFont(ofSize: 16)
                horizontalStackView.addArrangedSubview(propertyLabel)
                
                let valueLabel = UILabel()
                valueLabel.text = propertyValue ?? ""
                valueLabel.font = UIFont.systemFont(ofSize: 16)
                horizontalStackView.addArrangedSubview(valueLabel)
                
                basicInfoStackView.addArrangedSubview(horizontalStackView)
            }
        }
        setupNavigationBar()
        
        contentView.bottomAnchor.constraint(greaterThanOrEqualTo: openStreetMapsButton.bottomAnchor, constant: 25).isActive = true
    }
    
    
    private func setupNavigationBar() {
        if let country = country {
            let titleLabel = UILabel()
            titleLabel.text = country.name.common
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            titleLabel.textAlignment = .center
            navigationItem.titleView = titleLabel
        }
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
    }
    
    @objc private func openGoogleMaps() {
        guard let mapsURLString = country?.maps.openStreetMaps,
              let encodedURLString = mapsURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedURLString) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    @objc private func openOpenStreetMaps() {
        guard let mapsURLString = country?.maps.googleMaps,
              let encodedURLString = mapsURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedURLString) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    private func createHorizontalLine() -> UIView {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
        view.addSubview(line)
        return line
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
