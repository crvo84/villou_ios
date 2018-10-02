//
//  InitialViewModel.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 7/12/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation
import RxSwift

protocol InitialViewModelType {
    func showNextViewController() -> Completable
}

struct InitialViewModel: InitialViewModelType {
    let sceneCoordinator: SceneCoordinatorType

    func showNextViewController() -> Completable {
        let popularMoviesViewModel = PopularMoviesViewModel(sceneCoordinator: sceneCoordinator)
        return sceneCoordinator.transition(to: Scene.popularMovies(popularMoviesViewModel), type: .root(animated: true))
    }
}

