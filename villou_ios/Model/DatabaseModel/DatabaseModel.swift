//
//  DatabaseModel.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 10/3/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

protocol DatabaseModel: Codable {
}

extension DatabaseModel where Self: Object {

    func save(databaseManager: DatabaseManager = .default) {
        try? databaseManager.save(self)
    }

    func delete(databaseManager: DatabaseManager = .default) {
        try? databaseManager.delete(self)
    }

    static func retrieveAll(databaseManager: DatabaseManager) -> [Self] {
        let databaseModels = databaseManager.retrieveAll(Self.self) as? [Self]
        return databaseModels ?? []
    }

    static func retrieve(id: String, databaseManager: DatabaseManager = .default) -> Self? {
        return databaseManager.retrieve(Self.self, id: id) as? Self
    }
}
