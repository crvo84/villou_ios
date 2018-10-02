//
//  Theme.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 7/12/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation

import UIKit

struct Theme {
    struct Colors {
        static let main: UIColor = .darkGray
        static let bg: UIColor = .white
        static let buttonBg: UIColor = Colors.main
        static let buttonText: UIColor = .white
        static let textFieldText: UIColor = Colors.main
        static let textFieldErrorFlash: UIColor = .red
        static let spinner: UIColor = Colors.main
        static let primaryText: UIColor = .darkGray
        static let secondaryText: UIColor = .gray
    }

    struct Alpha {
        static let disabledButton: CGFloat = 0.3
    }

    struct Geometry {
        static let buttonCornerRadius: CGFloat = 5.0
        static let cellCornerRadius: CGFloat = 5.0
        static let spinnerMainHeight: CGFloat = 60.0
    }

    enum FontType {
        case primary
        case secondary

        var color: UIColor {
            switch self {
            case .primary: return Colors.primaryText
            case .secondary: return Colors.secondaryText
            }
        }
    }

    enum CornerRadius: CGFloat {
        case none = 0.0
        case standard = 5.0
    }
}

extension Theme.CornerRadius {
    func apply(to view: UIView) {
        view.layer.cornerRadius = rawValue
        view.layer.masksToBounds = true
    }
}
