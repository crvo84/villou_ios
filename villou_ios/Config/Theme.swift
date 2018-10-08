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
    enum Color {
        case main
        case background
        case primaryText
        case secondaryText
        case buttonBackground
        case buttonText
        case error

        var color: UIColor {
            switch self {
            case .main, .buttonBackground:
                return .orange
            case .background, .buttonText:
                return .white
            case .primaryText:
                return .darkGray
            case .secondaryText:
                return .gray
            case .error:
                return .red
            }
        }
    }

    enum FontSize: CGFloat {
        case extraExtraSmall = 7
        case extraSmall     = 9
        case small          = 11
        case mediumSmall    = 13
        case medium         = 15
        case mediumLarge    = 17
        case large          = 19
        case extraLarge     = 21
        case extraExtraLarge = 23
    }

    enum Font {
        case titleA(size: FontSize)
        case subtitleA(size: FontSize)
        case paragraphA(size: FontSize)
        case buttonTitleA(size: FontSize)

        var font: UIFont {
            switch self {
            case .titleA(let size), .subtitleA(let size), .paragraphA(let size),
                 .buttonTitleA(let size):
                return UIFont.systemFont(ofSize: size.rawValue)
            }
        }
    }

    enum Alpha: CGFloat {
        case disabledButton = 0.3
    }

    enum CornerRadius: CGFloat {
        case standard = 5.0
    }

    enum Kern: Double {
        case standard = 1.0
    }

    enum Image: String {
        case logo

        var image: UIImage {
            guard let image = UIImage(named: rawValue) else {
                fatalError("Asset for Theme.Image.\(rawValue) not found.")
            }
            return image
        }
    }

    enum SpinnerType {
        case standard(color: Color)
        case large(color: Color)

        var size: CGSize {
            switch self {
            case .standard:
                return CGSize(width: 30, height: 30)
            case .large:
                return CGSize(width: 60, height: 60)
            }
        }

        var color: UIColor {
            switch self {
            case .standard(let color), .large(let color):
                return color.color
            }
        }
    }
}

// MARK: Wrapper structs

extension Theme {
    struct Label {
        var textColor: Color
        var font: Font
    }

    struct Button {
        var titleColor: Color
        var backgroundColor: Color
        var font: Font
        var cornerRadius: CornerRadius?
    }

    struct NavigationBar {
        var backgroundColor: Color
        var tintColor: Color
        var preferredStatusBarStyle: UIStatusBarStyle
        var isTranslucent: Bool
        var titleFont: Font?
        var titleTextColor: Color?
    }

    struct NavigationItem {
        var titleView: UIView?
        var backButtonTitle: String?
        var backButtonTitleFont: Font
        var hidesBackButton: Bool
    }

    struct AttributedString {
        var textColor: Color
        var font: Font
        var kern: Kern
        var alignment: NSTextAlignment
        var text: String
    }
}

// MARK: Apply extensions

extension Theme.Label {
    func apply(to label: UILabel) {
        label.textColor = textColor.color
        label.font = font.font
    }
}

//extension Theme.AttributedString {
//    func apply(to label: UILabel) {
//        label.attributedText = AttributedStringMake { (attrs, ctx) in
//            attrs.foregroundColor = textColor.color
//            attrs.font = font.font
//            attrs.alignment = alignment
//            attrs.kern = kern.rawValue
//            ctx.append(text)
//        }
//    }
//}

extension Theme.Button {
    func apply(to button: UIButton) {
        button.setTitleColor(titleColor.color, for: .normal)
        button.backgroundColor = backgroundColor.color
        button.titleLabel?.font = font.font
        if let cornerRadius = cornerRadius {
            cornerRadius.apply(to: button)
        }
    }
}

extension Theme.NavigationBar {
    func apply(to navBar: UINavigationBar) {
        navBar.barTintColor = backgroundColor.color
        navBar.tintColor = tintColor.color
        navBar.isTranslucent = isTranslucent

        var titleAttrs = [NSAttributedString.Key: Any]()
        if let titleTextColor = titleTextColor {
            titleAttrs[.foregroundColor] = titleTextColor.color
        }
        if let titleFont = titleFont {
            titleAttrs[.font] = titleFont.font
        }

        navBar.titleTextAttributes = titleAttrs
    }
}

extension Theme.NavigationItem {
    func apply(to navItem: UINavigationItem) {
        navItem.titleView = titleView

        let backButton = UIBarButtonItem()
        backButton.title = backButtonTitle
        backButton.setTitleTextAttributes([NSAttributedString.Key.font : backButtonTitleFont.font], for: .normal)

        navItem.backBarButtonItem = backButton
        navItem.hidesBackButton = hidesBackButton
    }
}

extension Theme.CornerRadius {
    func apply(to view: UIView) {
        view.layer.cornerRadius = rawValue
        view.layer.masksToBounds = true
    }
}
