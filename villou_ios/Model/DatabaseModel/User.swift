//
//  User.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 10/3/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation

class User: BaseDatabaseModel {
    @objc dynamic var email: String!
    @objc dynamic var firstName: String!
    @objc dynamic var lastName: String!
}
