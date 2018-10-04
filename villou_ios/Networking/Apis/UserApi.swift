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
    case createUser(body: Encodable)
}

extension UsersApi: TargetType {
    var baseURL: URL {
        return URL(string: Config.Api.baseUrl)!
    }

    var path: String {
        switch self {
        case .createUser:
            return "/users"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createUser:
            return .post
        }
    }

    var task: Task {
        switch self {
        case let .createUser(body):
            return .requestJSONEncodable(body)
        }
    }

    var headers: [String : String]? {
        switch self {
        case .createUser:
            return nil
        }
    }

    var sampleData: Data {
        return Data() // TODO: implement for tests
    }
}
