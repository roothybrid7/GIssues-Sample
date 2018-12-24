//
//  Config.swift
//  Infra
//
//  Created by SATOSHI OKI on 12/19/18.
//

import Foundation

public struct Config {
    let endpoint: String
    let owner: String
    let repo: String

    public init(endpoint: String, owner: String, repo: String) {
        self.endpoint = endpoint
        self.owner = owner
        self.repo = repo
    }
}
