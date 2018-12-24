//
//  IssueUseCase.swift
//  Infra
//
//  Created by SATOSHI OKI on 12/19/18.
//

import Foundation
import RxSwift
import Domain

final class IssueUseCase: Domain.IssueUseCase {

    let api: IssueAPI

    init(api: IssueAPI) {
        self.api = api
    }

    func fetchIssues() -> Single<[Issue]> {
        return api.fetchIssues().debug()
    }

    func fetchIssue(number: Int) -> Single<Issue> {
        return api.fetchIssue(number: number)
    }
}
