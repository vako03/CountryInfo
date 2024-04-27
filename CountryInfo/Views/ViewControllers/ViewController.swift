//
//  ViewController.swift
//  CountryInfo
//
//  Created by vako on 21.04.24.
//
// ViewController.swift

import UIKit

class ViewController: UIViewController {
    
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
        
        // Hide back button
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        
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
    
    // MARK: - Alert
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: CountriesViewModelDelegate {
    func didUpdateCountries() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didEncounterError(error: Error) {
        DispatchQueue.main.async {
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterCountries(with: searchText)
    }
}
