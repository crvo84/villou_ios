//
//  UserServices.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 5/18/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol UserServicesType: ServicesType {
    func create(firstName: String, lastName: String, email: String, password: String) -> Observable<User>
    func login(email: String, password: String) -> Observable<Token>
    func getMe() -> Observable<User>
}

struct UserServices: UserServicesType {
    
    private var provider: MoyaProvider<UsersApi>

    init(token: Token?) {
        provider = UserServices.getProvider(type: UsersApi.self, token: token)
    }

    mutating func setToken(_ token: Token?) {
        provider = UserServices.getProvider(type: UsersApi.self, token: token)
    }

    func create(firstName: String, lastName: String, email: String, password: String) -> Observable<User> {
        let requestDTO = UserServicesRequestDTO.Create(firstName: firstName, lastName: lastName, email: email, password: password)
        return provider.rx.request(.create(body: requestDTO))
            .map(User.self)
            .asObservable()
    }

    func login(email: String, password: String) -> Observable<Token> {
        let requestDTO = UserServicesRequestDTO.Login(email: email, password: password)
        return provider.rx.request(.login(body: requestDTO))
            .map(Token.self)
            .asObservable()
    }

    func getMe() -> Observable<User> {
        return provider.rx.request(.getMe)
            .map(User.self)
            .asObservable()
    }
}
