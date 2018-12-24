//
//  ViewModelProvider.swift
//  GIssues
//
//  Created by SATOSHI OKI on 12/19/18.
//

import Foundation
import Domain

final class ViewModelProvider {

    private let useCaseResolver: UseCaseResolver

    init(useCaseResolver: UseCaseResolver) {
        self.useCaseResolver = useCaseResolver
    }

    func makeIssues() -> IssuesViewModel {
        return IssuesViewModel(useCase: useCaseResolver.getIssueUseCase())
    }
}
