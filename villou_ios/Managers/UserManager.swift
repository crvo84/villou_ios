//
//  UserManager.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 9/16/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation

class UserManager {

    private let userServices: UserServicesType
    private let databaseManager: DatabaseManager

    init(userServices: UserServicesType = UserServices(),
         databaseManager: DatabaseManager = .default) {
        self.userServices = userServices
        self.databaseManager = databaseManager
    }

    private(set) var user: User? {
        get {
            return User.retrieveAll(manager: databaseManager).first
        }
        set {
            if let newValue = newValue {
                // create/update
                newValue.save(manager: databaseManager)
            } else {
                // delete
                user?.delete(manager: databaseManager)
            }
        }
    }
}
