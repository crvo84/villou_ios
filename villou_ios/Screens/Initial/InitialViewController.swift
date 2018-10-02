//
//  InitialViewController.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 7/12/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation
import RxSwift

class InitialViewController: MyTimeViewController, BindableType {

    var viewModel: InitialViewModel!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        initialSetup()

        // After some launch animation:
        showNextViewController()
    }

    // MARK: Setup

    func bindViewModel() {}

    fileprivate func initialSetup() {
        let sceneCoordinator = SceneCoordinator(window: view.window!)
        self.viewModel = InitialViewModel(sceneCoordinator: sceneCoordinator)
    }

    // MARK: Navigation

    func showNextViewController() {
        viewModel.showNextViewController()
            .subscribe()
            .disposed(by: disposeBag)
    }
}

