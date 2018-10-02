//
//  Scene+ViewController.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 5/18/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import UIKit

extension Scene {

    func viewController() -> UIViewController {
        let storyboard = getStoryboard()
        switch self {
        case let .popularMovies(viewModel):
            let nav = storyboard.instantiateViewController(withIdentifier: "PopularMovies") as! UINavigationController
            var vc = nav.viewControllers.first! as! PopularMoviesViewController
            vc.bindViewModel(to: viewModel)
            return vc
        }

    }

    private func getStoryboard() -> UIStoryboard {
        let name: String
        switch self {
        case .popularMovies:
            name = "PopularMovies"
        }

        return UIStoryboard(name: name, bundle: nil)
    }
}
