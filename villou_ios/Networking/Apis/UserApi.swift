//
//  UsersApi.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 5/18/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation
import Moya

enum UsersApi {
    case create(body: Encodable)
    case login(body: Encodable)
    case getMe
}

extension UsersApi: TargetType, AccessTokenAuthorizable {

    var baseURL: URL {
        return URL(string: Config.Api.baseUrl)!
    }

    var path: String {
        switch self {
        case .create:
            return "/users"
        case .login:
            return "/users/login"
        case .getMe:
            return "/users/me"
        }
    }

    var method: Moya.Method {
        switch self {
        case .create, .login:
            return .post
        case .getMe:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .create(body):
            return .requestJSONEncodable(body)
        case let .login(body):
            return .requestJSONEncodable(body)
        case .getMe:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        case .create, .login, .getMe:
            return nil
        }
    }

    var authorizationType: AuthorizationType {
        switch self {
        case .create, .login:
            return .none
        case .getMe:
            return .bearer
        }
    }

    var sampleData: Data {
        return Data() // TODO: implement for tests
    }
}
