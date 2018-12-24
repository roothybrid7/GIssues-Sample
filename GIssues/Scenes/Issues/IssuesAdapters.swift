//
//  IssuesAdapters.swift
//  GIssues
//
//  Created by SATOSHI OKI on 12/19/18.
//

import Foundation
import RxSwift
import RxCocoa

protocol IssuesControlable {
    var fetcher: Driver<Void> { get }
    var selector: Driver<Int> { get }
}

protocol IssuesPresentable {
    var loading: Driver<Bool> { get }
    var issues: Driver<[IssueSummaryViewModel]> { get }
    var selectedIssueNumber: Driver<Int> { get }
}

struct IssueHandler: IssuesControlable {
    let fetcher: Driver<Void>
    let selector: Driver<Int>
}

struct IssuesPresenter: IssuesPresentable {
    let loading: Driver<Bool>
    let issues: Driver<[IssueSummaryViewModel]>
    let selectedIssueNumber: Driver<Int>
}
