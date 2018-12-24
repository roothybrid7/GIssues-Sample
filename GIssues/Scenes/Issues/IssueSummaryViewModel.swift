//
//  IssueSummaryViewModel.swift
//  GIssues
//
//  Created by SATOSHI OKI on 12/19/18.
//

import Foundation
import Domain

final class IssueSummaryViewModel {
    let login: String
    let avatarURL: URL
    let title: String
    let updated: String
    let issue: Issue

    init(issue: Issue) {
        self.issue = issue
        self.login = issue.user.login
        self.avatarURL = issue.user.avatarURL
        self.title = issue.title
        self.updated = DateFormatter.fullDateTime.string(from: issue.updatedAt)
    }
}
