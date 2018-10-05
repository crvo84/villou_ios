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

class BaseViewController: UIViewController, SpinnerViewable {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = Theme.Color.background.color
    }
}
