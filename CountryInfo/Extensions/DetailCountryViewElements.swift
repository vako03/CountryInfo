//
//  DetailCountryViewElements.swift
//  CountryInfo
//
//  Created by vako on 27.04.24.
//

import UIKit
import SafariServices

extension UILabel {
    static func makeCustomLabel(text: String?, font: UIFont, textColor: UIColor = .black, numberOfLines: Int = 1, alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = font
        label.textColor = textColor
        label.numberOfLines = numberOfLines
        label.textAlignment = alignment
        return label
    }
}

extension UIButton {
    static func makeCustomButton(image: UIImage?, backgroundColor: UIColor = .clear, target: Any?, action: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.backgroundColor = backgroundColor
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
}

extension UIStackView {
    static func makeCustomStackView(axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.spacing = spacing
        return stackView
    }
}
