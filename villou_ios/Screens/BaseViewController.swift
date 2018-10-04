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
            make.width.height.equalTo(Constants.Geometry.spinnerMainHeight)
        }
    }

    // MARK: Activity Indicator

    // TODO: Implement in a protocol extension
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
