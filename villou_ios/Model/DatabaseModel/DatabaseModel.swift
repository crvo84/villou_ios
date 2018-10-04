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

    func save(manager: DatabaseManager = .default) {
        try? manager.save(self)
    }

    func delete(manager: DatabaseManager = .default) {
        try? manager.delete(self)
    }

    static func retrieveAll(manager: DatabaseManager) -> [Self] {
        let databaseModels = manager.retrieveAll(Self.self) as? [Self]
        return databaseModels ?? []
    }

    static func retrieve(id: String, manager: DatabaseManager = .default) -> Self? {
        return manager.retrieve(Self.self, id: id) as? Self
    }
}

class BaseDatabaseModel: Object, DatabaseModel {
    @objc dynamic var id: String!

    override static func primaryKey() -> String? {
        return "id"
    }
}
