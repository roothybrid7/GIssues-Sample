//
//  IssueUseCase.swift
//  Domain
//
//  Created by SATOSHI OKI on 12/19/18.
//

import Foundation
import RxSwift

public protocol IssueUseCase {
    func fetchIssues() -> Single<[Issue]>
    func fetchIssue(number: Int) -> Single<Issue>
}
