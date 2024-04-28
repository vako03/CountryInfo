//
//  CountriesViewController.swift
//  CountryInfo
//
//  Created by vako on 21.04.24.
//

import UIKit
import Speech

class CountriesViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel = CountriesViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Countries"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "CountryCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = AppColors.customBackgroundColor
        
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 19.9),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 11),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 18),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar.showsBookmarkButton = true
        searchBar.setImage(UIImage(systemName: "mic"), for: .bookmark, state: .normal)
        searchBar.tintColor = .systemBlue
        
        searchBar.barTintColor = .clear
        searchBar.backgroundImage = UIImage()
        
    }
    
    // MARK: - ViewModel Binding
    
    private func bindViewModel() {
        viewModel.delegate = self
        viewModel.fetchData()
    }
}

// MARK: - UISearchBarDelegate

extension CountriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterCountries(with: searchText)
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        startSpeechRecognition()
    }
    
    func startSpeechRecognition() {
        let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
        let request = SFSpeechRecognitionRequest()
        speechRecognizer?.recognitionTask(with: request) { [weak self] (result, error) in
            guard let result = result else {
                print("Recognition failed: \(error?.localizedDescription ?? "No error")")
                return
            }
            if result.isFinal {
                let spokenText = result.bestTranscription.formattedString
                self?.searchBar.text = spokenText
                self?.viewModel.filterCountries(with: spokenText)
            }
        }
    }
}

// MARK: - CountriesViewModelDelegate

extension CountriesViewController: CountriesViewModelDelegate {
    func didUpdateCountries() {
        tableView.reloadData()
    }
    
    func didEncounterError(error: Error) {
        print("Error fetch data: \(error.localizedDescription)")
    }
}
