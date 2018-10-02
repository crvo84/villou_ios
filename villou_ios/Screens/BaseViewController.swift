//
//  BaseViewController.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 7/12/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation
import RxSwift
import SnapKit

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = Theme.Colors.bg

        // Activity Indicator
        view.addSubview(spinner)
        spinner.color = Theme.Colors.spinner
        spinner.hidesWhenStopped = true
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(Theme.Geometry.spinnerMainHeight)
        }
    }

    func themeSetupButtons(_ buttons: [UIButton]) {
        _ = buttons.map {
            $0.backgroundColor = Theme.Colors.buttonBg
            $0.setTitleColor(Theme.Colors.buttonText, for: .normal)
            $0.layer.cornerRadius = Theme.Geometry.buttonCornerRadius
            $0.layer.masksToBounds = true
        }
    }

    func themeSetupTextFields(_ textFields: [UITextField]) {
        _ = textFields.map {
            $0.textColor = Theme.Colors.textFieldText
        }
    }

    func themeSetupLabels(_ labels: [UILabel], fontType: Theme.FontType) {
        _ = labels.map {
            $0.textColor = fontType.color
        }
    }

    func themeSetupBarButtonItems(_ items: [UIBarButtonItem]) {
        _ = items.map {
            $0.tintColor = Theme.Colors.main
        }
    }

    // MARK: Activity Indicator

    func showSpinner(userInteractionEnabled: Bool) {
        view.bringSubview(toFront: spinner)
        view.isUserInteractionEnabled = userInteractionEnabled
        guard !spinner.isAnimating else { return }
        spinner.startAnimating()
    }

    func hideSpinner() {
        view.isUserInteractionEnabled = true
        guard spinner.isAnimating else { return }
        spinner.stopAnimating()
    }
}
