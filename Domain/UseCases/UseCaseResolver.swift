//
//  UseCaseResolver.swift
//  Domain
//
//  Created by SATOSHI OKI on 12/19/18.
//

import Foundation

public protocol UseCaseResolver {
    func getIssueUseCase() -> IssueUseCase
}
