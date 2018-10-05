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
        switch self {
        case let .intro(viewModel):
            var vc = storyboard.instantiateViewController(withIdentifier: identifier) as! IntroViewController
            vc.bind(to: viewModel)
            return vc
        }
    }

    private var storyboard: UIStoryboard {
        return UIStoryboard(name: identifier, bundle: nil)
    }

    private var identifier: String {
        switch self {
        case .intro:
            return "Intro"
        }
    }
}
