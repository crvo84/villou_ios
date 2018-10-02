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

protocol UserServicesType {
    func createUser(requestDTO: CreateUserRequestDTO) -> Observable<CreateUserResponseDTO>
}

struct UserServices: UserServicesType {

    private let provider: MoyaProvider<UsersApi>

    init(provider: MoyaProvider<UsersApi> = UserServices.getDefaultProvider()) {
        self.provider = provider
    }

    func createUser(requestDTO: CreateUserRequestDTO) -> Observable<CreateUserResponseDTO> {
        return provider.rx.request(.createUser(body: requestDTO))
            .map(CreateUserResponseDTO.self)
            .asObservable()
    }

    // MARK: - Helper methods

    private static func getDefaultProvider() -> MoyaProvider<UsersApi> {
        return MoyaProvider<UsersApi>(plugins: [NetworkLoggerPlugin(verbose: true)])
    }
}
