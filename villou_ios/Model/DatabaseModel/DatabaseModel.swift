//
//  DatabaseModel.swift
//
//  Created by Carlos Villanueva Ousset on 9/30/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation
import RealmSwift

protocol DatabaseModel: Codable {

}

extension DatabaseModel: Object {
    func save(realm: Realm = try! Realm()) { // + Rx (saves or create?)
        // DatabaseManager.save
    }

    func delete(real: Realm = try! Realm()) { // + Rx
        // DatabaseManager.delete
    }

//    func get // + Rx
}
