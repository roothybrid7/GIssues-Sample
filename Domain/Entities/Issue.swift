//
//  Issue.swift
//  Domain
//
//  Created by SATOSHI OKI on 12/19/18.
//

import Foundation

public struct Issue: Decodable, Equatable {
    public let number: Int
    public let title: String
    public let body: String
    public let url: URL
    public let user: User
    public let updatedAt: Date

    public init(number: Int, title: String, body: String, url: URL, user: User, updatedAt: Date = Date(timeIntervalSince1970: 0)) {
        self.number = number
        self.title = title
        self.body = body
        self.url = url
        self.user = user
        self.updatedAt = updatedAt
    }
}
