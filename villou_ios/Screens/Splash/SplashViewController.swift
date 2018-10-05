//
//  SplashViewController.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 7/12/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController, BindableType {

    var viewModel: SplashViewModel!

    // MARK: - Life cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupViewModel()
        // Add logo animation here... then showNextViewController:
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            self.showNextViewController()
        }
    }

    // MARK: Setup

    func bindViewModel() {
    }

    override func setupUI() {
        super.setupUI()

        navigationController?.isNavigationBarHidden = true
    }

    private func setupViewModel() {
        let sceneCoordinator = SceneCoordinator(window: view.window!)
        self.viewModel = SplashViewModel(sceneCoordinator: sceneCoordinator)
    }

    // MARK: Navigation

    func showNextViewController() {
        viewModel.showNextViewController()
            .subscribe()
            .disposed(by: disposeBag)
    }
}

