//
//  IntroViewModel.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 10/4/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import RxSwift

protocol IntroViewModelType {
    func showNextViewController() -> Completable
}

struct IntroViewModel: IntroViewModelType {
    let sceneCoordinator: SceneCoordinatorType

    func showNextViewController() -> Completable {
        // TODO: show initial view controller
        return Completable.empty()
    }
}
