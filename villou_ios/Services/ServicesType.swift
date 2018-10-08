//
//  ServicesType.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 10/7/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation
import Moya

protocol ServicesType {
    mutating func setToken(_ token: Token?)
}

extension ServicesType {
    static func getProvider<T>(type: T.Type, token: Token?,
                               isDebugMode: Bool = Config.Debug.isOn,
                               useStubs: Bool = Config.Debug.useStubs) -> MoyaProvider<T> {
        let stubMode: StubBehavior = useStubs ? .delayed(seconds: Config.Debug.stubsDelay) : .never

        return MoyaProvider<T>(stubClosure: {_ in stubMode },
                               plugins: getProviderPlugins(token: token, isDebugMode: isDebugMode))
    }

    private static func getProviderPlugins(token: Token?, isDebugMode: Bool) -> [PluginType] {
        var plugins = [PluginType]()
        if let token = token {
            plugins.append(AccessTokenPlugin(tokenClosure: token.token))
        }
        if isDebugMode {
            plugins.append(NetworkLoggerPlugin(verbose: true))
        }
        return plugins
    }
}
