//
//  Data+Extensions.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 10/7/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation

extension Data {
    static var zero: Data {
        return Data(base64Encoded: "")!
    }
}
