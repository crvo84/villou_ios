//
//  KeychainManager.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 10/7/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation
import KeychainAccess


class KeychainManager {

    private static let basePrefix = Bundle.main.bundleIdentifier!

    enum Store: String {
        case session
    }

    enum ItemKey: String {
        case accessToken
    }

    static let `default` = KeychainManager()

    // MARK: String storage

    func setString(_ str: String, store: Store, key: ItemKey) throws {
        try keychain(for: store).set(str, key: key.rawValue)
    }

    func getString(store: Store, key: ItemKey) -> String? {
        return (try? keychain(for: store).get(key.rawValue)) ?? nil
    }

    // MARK: Data storage

    func setData(_ data: Data, store: Store, key: ItemKey) throws {
        try keychain(for: store).set(data, key: key.rawValue)
    }

    func getData(store: Store, key: ItemKey) -> Data? {
        return (try? keychain(for: store).getData(key.rawValue)) ?? nil
    }

    // MARK: Remove items

    func removeItem(at store: Store, key: ItemKey) throws {
        try keychain(for: store).remove(key.rawValue)
    }

    func clearStore(_ store: Store) throws {
        try keychain(for: store).removeAll()
    }

    // TODO: Swift 4.2
//    func clearAllStores() throws {
//        for store in Store.allCases {
//            keychain(for: store).removeAll()
//        }
//    }

    // MARK: Helper methods

    private func keychain(for store: Store) -> Keychain {
        return Keychain(service: service(for: store))
    }

    private func service(for store: Store) -> String {
        return KeychainManager.basePrefix + store.rawValue
    }
}
