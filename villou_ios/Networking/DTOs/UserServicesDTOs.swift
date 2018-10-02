//
//  UserServicesDTOs.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 9/30/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation

// --------------------
// MARK: - Create User
// --------------------

struct CreateUserRequestDTO: Encodable {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
}

struct CreateUserResponseDTO: Decodable {
    let accessToken: String
}
