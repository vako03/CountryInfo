//
//  ViewController+TableView.swift
//  CountryInfo
//
//  Created by vako on 26.04.24.
//
import UIKit

extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCountries * 2 - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryTableViewCell
            if let country = viewModel.country(at: indexPath.row / 2) {
                cell.configure(with: country)
            }
            return cell
        } else {
            let cell = UITableViewCell()
            cell.backgroundColor = AppColors.customBackgroundColor
            return cell
        }
    }
}

extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row % 2 == 0 {
            if let selectedCountry = viewModel.country(at: indexPath.row / 2) {
                let detailVC = DetailCountryViewController()
                detailVC.viewModel = DetailCountryViewModel(country: selectedCountry)
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row % 2 == 0 ? 50 : 10
    }
}
