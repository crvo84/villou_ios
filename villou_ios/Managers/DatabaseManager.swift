//
//  DatabaseManager.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 9/30/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager {

    static let `default` = DatabaseManager()

    let realm: Realm

    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }

    /// Adds or updates an existing object into the database.
    func save<T: DatabaseModel>(_ model: T) throws {
        try realm.write {
            realm.add(assertRealmObject(model), update: true)
        }
    }

    /// Returns all instances of DatabaseModel of the given type stored in the database.
    func retrieveAll<T: DatabaseModel>(_ type: T.Type) -> [Object] {
        return realm.objects(assertRealmObjectType(type)).toArray()
    }

    /// Retrieves the single instance of a given DatabaseModel type with the given unique id.
    func retrieve<T: DatabaseModel>(_ type: T.Type, id: String) -> Object? {
        return realm.object(ofType: assertRealmObjectType(type), forPrimaryKey: id)
    }

    /// Deletes an object from the database.
    /// Once the object is deleted it is considered invalidated.
    func delete<T: DatabaseModel>(_ model: T) throws {
        try realm.write {
            realm.delete(assertRealmObject(model))
        }
    }

    /// Deletes all objects from the Realm.
    func reset() throws {
        try realm.write {
            realm.deleteAll()
        }
    }

    private func assertRealmObject<T: DatabaseModel>(_ databaseModel: T) -> Object {
        guard let object = databaseModel as? Object else {
            fatalError("Type: \(databaseModel.self) is not a Realm Object")
        }
        return object
    }

    private func assertRealmObjectType<T: DatabaseModel>(_ databaseModelType: T.Type) -> Object.Type {
        guard let objectType = databaseModelType as? Object.Type else {
            fatalError("Type: \(databaseModelType) is not a Realm Object")
        }
        return objectType
    }
}
