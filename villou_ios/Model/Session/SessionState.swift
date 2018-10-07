//
//  SessionState.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 10/7/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation

enum SessionState {
    case none
    case valid(user: User, token: Token)
    case needsUser(token: Token)

    var user: User? {
        switch self {
        case .none, .needsUser:
            return nil
        case let .valid(user, _):
            return user
        }
    }

    var token: Token? {
        switch self {
        case .none:
            return nil
        case let .needsUser(token):
            return token
        case let .valid(_, token):
            return token
        }
    }
}
