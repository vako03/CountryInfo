//
//  UIViewController+NavigationBar.swift
//  CountryInfo
//
//  Created by vako on 28.04.24.
//
import UIKit

extension UIViewController {
    func setupNavigationBar(withTitle title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
    }
}
