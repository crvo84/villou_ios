//
//  VillouError.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 5/18/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation

enum VillouError: Error {
//    case invalidServerResponse
    case decoding(type: Decodable.Type, underlyingError: Error?)
    case unauthorizedRequest
}
