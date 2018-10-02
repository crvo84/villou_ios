//
//  PopularMoviesViewModel.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 5/18/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation
import RxSwift
import Action

protocol PopularMoviesViewModelType {
    var movies: Observable<[Movie]> { get }
}

class PopularMoviesViewModel: PopularMoviesViewModelType {

    private let disposeBag = DisposeBag()
    private let sceneCoordinator: SceneCoordinatorType
    private let moviesService: MoviesServiceType
    private let moviesSubject = Variable<[Movie]>([])
    private var nextPage = Variable<Int?>(1)
    private let isLoadingSubject = Variable<Bool>(false)

    var movies: Observable<[Movie]> {
        return moviesSubject.asObservable()
    }

    var isLoading: Observable<Bool> {
        return isLoadingSubject.asObservable()
    }

    init(sceneCoordinator: SceneCoordinatorType, moviesService: MoviesServiceType = MoviesService()) {
        self.sceneCoordinator = sceneCoordinator
        self.moviesService = moviesService
    }

    func loadNextPage() -> Completable {
        guard let page = nextPage.value, !isLoadingSubject.value else {
            return Completable.empty()
        }

        return moviesService.popularMovies(page: page)
            .do(onNext: { [weak self] movies in
                self?.moviesSubject.value.append(contentsOf: movies)
                self?.isLoadingSubject.value = false
                self?.nextPage.value = page + 1
            }, onError: { [weak self] error in
                self?.isLoadingSubject.value = false
                self?.nextPage.value = nil
            })
            .ignoreElements()
    }
}
