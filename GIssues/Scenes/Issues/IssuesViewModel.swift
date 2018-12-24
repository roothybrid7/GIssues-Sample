//
//  IssuesViewModel.swift
//  GIssues
//
//  Created by SATOSHI OKI on 12/19/18.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftUtilities
import Domain

final class IssuesViewModel {
    private let useCase: IssueUseCase

    init(useCase: IssueUseCase) {
        self.useCase = useCase
    }

    func build(controller: IssuesControlable) -> IssuesPresentable {
        let activityIndicator = ActivityIndicator()
        let issues = controller.fetcher.flatMapLatest { _ in
            return self.useCase.fetchIssues()
                .trackActivity(activityIndicator)
                .asDriver(onErrorDriveWith: .empty())
                .map({ $0.map({ IssueSummaryViewModel(issue: $0) }) })
        }
        let loading = activityIndicator.asDriver()
        let selectedIssueNumber = controller.selector.withLatestFrom(issues) { index, issues -> Int in
            return issues[index].issue.number
        }
        return IssuesPresenter(loading: loading, issues: issues, selectedIssueNumber: selectedIssueNumber)
    }
}
