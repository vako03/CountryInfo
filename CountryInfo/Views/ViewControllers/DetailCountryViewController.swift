//
//  DetailCountryViewController.swift
//  CountryInfo
//
//  Created by vako on 22.04.24.
//

import UIKit

class DetailCountryViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: DetailCountryViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var detailCountryView: DetailCountryView = {
        let view = DetailCountryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateUI()
    }
    
    // MARK: - View Setup
    
    private func setupViews() {
        view.backgroundColor = AppColors.customBackgroundColor
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: detailCountryView.backButton)
        
        view.addSubview(detailCountryView)
        
        NSLayoutConstraint.activate([
            detailCountryView.topAnchor.constraint(equalTo: view.topAnchor),
            detailCountryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailCountryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailCountryView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        updateUI()
    }
    
    private func updateUI() {
        
        title = viewModel?.country.name.common
        detailCountryView.viewModel = viewModel
    }
    
    // MARK: - Actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
