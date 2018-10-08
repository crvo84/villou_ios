//
//  Config.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 5/27/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation

struct Config {
    struct Debug {
        static let isOn = true
        static let useStubs = true
        static let stubsDelay: TimeInterval = 1.0
    }

    struct Api {
        static let baseUrl = ""
    }
}
