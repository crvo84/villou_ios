//
//  SplashViewModel.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 7/12/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import RxSwift

protocol SplashViewModelType {
    func showNextViewController() -> Completable
}

struct SplashViewModel: SplashViewModelType {
    let sceneCoordinator: SceneCoordinatorType

    func showNextViewController() -> Completable {
        // If logged user -> show Logged View Controller
        // else -> show intro view controller
        return Completable.empty()
    }
}

