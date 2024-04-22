//
//  ViewController.swift
//  CountryInfo
//
//  Created by vako on 21.04.24.
//
import UIKit

// MARK: - ViewController

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Countries"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "CountryCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var countries: [Element] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 19.9),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets.zero
    }
    
    // MARK: - Data Fetching
    
    private func fetchData() {
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                self.countries = try decoder.decode([Element].self, from: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count * 2 - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryTableViewCell
            let countryIndex = indexPath.row / 2
            let country = countries[countryIndex]
            cell.configure(with: country)
            return cell
        } else {
            let cell = UITableViewCell()
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row % 2 == 0 {
            let selectedCountry = countries[indexPath.row / 2]
            let detailVC = DetailCountryViewController()
            detailVC.country = selectedCountry
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return 50
        } else {
            return 10
        }
    }
}