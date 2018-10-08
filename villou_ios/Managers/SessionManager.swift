//
//  UserManager.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 9/16/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation
import RxSwift

protocol SessionManagerType {
    var state: Variable<SessionState> { get }

    func signUp(firstName: String, lastName: String, email: String, password: String) -> Observable<SessionState>
    func signIn(email: String, password: String) -> Observable<SessionState>
    func signOut() -> Observable<SessionState>
}

class SessionManager {

    private var userServices: UserServicesType
    private let databaseManager: DatabaseManager
    private let keychainManager: KeychainManager

    let disposeBag = DisposeBag()
    var state: Variable<SessionState>

    init(databaseManager: DatabaseManager = .default,
         keychainManager: KeychainManager = .default) {
        let token = SessionManager.getToken(keychainManager: keychainManager)

        self.userServices = UserServices(token: token)
        self.databaseManager = databaseManager
        self.keychainManager = keychainManager

        let currentState = SessionManager.getState(withToken: token, user: nil)
        self.state = Variable<SessionState>(currentState)

        state.asObservable()
            .subscribe(onNext: { state in
                SessionManager.saveToken(fromState: state, keychainManager: keychainManager)
            })
            .disposed(by: disposeBag)
    }

    // MARK: - Helper methods

    /// Returns the corresponding 'SessionState' for the given session and user.
    fileprivate static func getState(withToken token: Token?, user: User?) -> SessionState {
        guard let token = token
            else { return .none }

        guard let user = user
            else { return .needsUser(token: token) }

        return .valid(user: user, token: token)
    }

    /// Access the existing data stored in the given keychain and returns a 'Token' constructed from it.
    fileprivate static func getToken(keychainManager: KeychainManager) -> Token? {
        guard
            let jsonData = keychainManager.getData(store: .session, key: .accessToken),
            let token = try? Token(jsonData: jsonData)
            else { return nil}

        return token
    }

    /// Stores the given SessionState's token in the given KeychainSwift
    fileprivate static func saveToken(fromState state: SessionState, keychainManager: KeychainManager) {
        guard
            let token = state.token,
            let data = token.toJsonData() else {
                // no session <=> .none state
                try? keychainManager.removeItem(at: .session, key: .accessToken)
                return
        }

        try? keychainManager.setData(data, store: .session, key: .accessToken)
    }
}

extension SessionManager: SessionManagerType {

    func signUp(firstName: String, lastName: String, email: String, password: String) -> Observable<SessionState> {
        return userServices.create(firstName: firstName, lastName: lastName, email: email, password: password)
            .flatMap { _ in self.signIn(email: email, password: password) }
    }

    func signIn(email: String, password: String) -> Observable<SessionState> {
        return userServices.login(email: email, password: password)
            .flatMap { self.reloadUser(token: $0) }
    }

    private func reloadUser(token: Token) -> Observable<SessionState> {
        userServices.setToken(token)
        return userServices.getMe()
            .map { [weak self] in
                let newState = SessionManager.getState(withToken: token, user: $0)
                self?.state.value = newState
                return newState
        }
    }

    private func resetKeychain() throws {
        try keychainManager.clearAllStores()
    }

    private func resetDatabase() throws {
        try databaseManager.reset()
    }

    func signOut() -> Observable<SessionState> {
        return Observable.create { [weak self] observer in
            try? self?.resetDatabase()
            try? self?.resetKeychain()
            self?.state.value = .none
            observer.onNext(self?.state.value ?? .none)
            observer.onCompleted()

            return Disposables.create()
        }
    }
}
