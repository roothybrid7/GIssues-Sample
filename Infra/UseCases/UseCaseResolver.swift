//
//  UseCaseResolver.swift
//  Infra
//
//  Created by SATOSHI OKI on 12/19/18.
//

import Foundation
import Alamofire
import Domain

public final class UseCaseResolver: Domain.UseCaseResolver {

    let config: Config

    public init(config: Config) {
        self.config = config
    }

    public func getIssueUseCase() -> Domain.IssueUseCase {
        let apiClient = IssueAPIClient(endpoint: config.endpoint, owner: config.owner, repo: config.repo, sessionManager: SessionManager.default)
        return IssueUseCase(api: apiClient)
    }
}
