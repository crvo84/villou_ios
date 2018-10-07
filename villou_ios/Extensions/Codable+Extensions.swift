//
//  Codable+Extensions.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 10/7/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import Foundation

extension Decodable {
    init(jsonData: Data, decoder: JSONDecoder = JSONDecoder()) throws {
        self = try decoder.decode(Self.self, from: jsonData)
    }
}

extension Encodable {
    func toJsonData(encoder: JSONEncoder = JSONEncoder()) -> Data? {
        return try? encoder.encode(self)
    }
}
