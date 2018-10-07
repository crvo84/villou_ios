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
struct UserServicesRequestDTO {
    struct Create: Encodable {
        let firstName: String
        let lastName: String
        let email: String
        let password: String
    }

    struct Login: Encodable {
        let email: String
        let password: String
    }
}
