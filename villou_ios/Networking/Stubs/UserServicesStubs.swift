//
//  UserServicesStubs.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 10/7/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation

struct UserServicesStubs {
    static func create(firstName: String, lastName: String, email: String) -> Data {
        return User(id: "1", firstName: firstName, lastName: lastName, email: email).toJsonData()!
    }

    static func login() -> Data {
        return Token(token: "accessToken").toJsonData()!
    }

    static func getMe() -> Data {
        return User(id: "1", firstName: "Carlos", lastName: "Villanueva", email: "crvo84@gmail.com").toJsonData()!
    }
}
