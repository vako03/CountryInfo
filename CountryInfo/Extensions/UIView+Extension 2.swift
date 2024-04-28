//
//  UIView+Extension
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
            .foregroundColor: AppColors.customTextColor
        ]
    }
}


// UIView+Extension.swift
//
//extension UIView {
//    var firstAvailableUIViewController: UIViewController? {
//        var responder: UIResponder? = self
//        while let nextResponder = responder?.next {
//            if let viewController = nextResponder as? UIViewController {
//                return viewController
//            }
//            responder = nextResponder
//        }
//        return nil
//    }
//}
