//
//  User.swift
//  Domain
//
//  Created by SATOSHI OKI on 12/19/18.
//

import Foundation

public struct User: Decodable, Equatable {
    public let login: String
    public let avatarURL: URL

    public init(login: String, avatarURL: URL) {
        self.login = login
        self.avatarURL = avatarURL
    }

    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl // .convertFromSnakeCase
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.login = try container.decode(String.self, forKey: .login)
        self.avatarURL = try container.decode(URL.self, forKey: .avatarUrl)
    }
}
