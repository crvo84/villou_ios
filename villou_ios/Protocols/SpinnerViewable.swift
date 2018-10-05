//
//  SpinnerViewable.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 10/4/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import NVActivityIndicatorView

protocol SpinnerViewable {

}

extension SpinnerViewable where Self: UIViewController {
    private var spinnerAnimationType: NVActivityIndicatorType {
        return .lineSpinFadeLoader
    }

    func showSpinner(type: Theme.SpinnerType = .standard(color: .main),
                     disableUserInteraction: Bool = true) {
        guard view.currentSpinner == nil else { return } // spinner already added

        if disableUserInteraction {
            setUserInteraction(enabled: false)
        }

        let spinner = NVActivityIndicatorView(frame: CGRect(origin: .zero, size: type.size),
                                              type: spinnerAnimationType, color: type.color)
        view.addSubview(spinner)
        // TODO: fade in animation?
        spinner.center = view.center
        spinner.startAnimating()
    }

    func hideSpinner() {
        guard let spinner = view.currentSpinner else { return }

        // TODO: fade out animation?
        spinner.stopAnimating()
        spinner.removeFromSuperview()

        setUserInteraction(enabled: true)
    }

    private func setUserInteraction(enabled: Bool) {
        view.isUserInteractionEnabled = enabled
        navigationController?.view.isUserInteractionEnabled = enabled
        tabBarController?.view.isUserInteractionEnabled = enabled
    }
}

fileprivate extension UIView {
    var currentSpinner: NVActivityIndicatorView? {
        return subviews.compactMap { $0 as? NVActivityIndicatorView }.first
    }
}
