//
//  UIView+Extensions.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 10/4/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import UIKit

extension UIView {

    func errorFlash() {
        flash(withColor: Theme.Color.error.color)
    }

    func flash(withColor color: UIColor) {
        let originalColor = backgroundColor ?? .white
        animateBackground(to: color) { [weak self] in
            self?.animateBackground(to: originalColor)
        }
    }

    private func animateBackground(to color: UIColor, completion: (() -> ())? = nil) {
        UIView.animate(withDuration: Constants.Time.fadeInOut, animations: { [weak self] in
            self?.backgroundColor = color
        }) { _ in
            completion?()
        }
    }
}
