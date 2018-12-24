//
//  IssueAPI.swift
//  Infra
//
//  Created by SATOSHI OKI on 12/19/18.
//

import Foundation
import Alamofire
import RxSwift
import Domain

protocol IssueAPI {
    func fetchIssues() -> Single<[Issue]>
    func fetchIssue(number: Int) -> Single<Issue>
}

final class IssueAPIClient: IssueAPI {
    let endpoint: String
    let owner: String
    let repo: String
    let sessionManager: SessionManager
    let responseQueue: DispatchQueue?

    var baseURL: URL {
        return URL(string: "\(endpoint)")!.appendingPathComponent("repos/\(owner)/\(repo)/issues")
    }

    var headers: HTTPHeaders {
        return [
            "Accept": "application/json"
        ]
    }

    init(endpoint: String, owner: String, repo: String, sessionManager: SessionManager, responseQueue: DispatchQueue? = nil) {
        self.endpoint = endpoint
        self.owner = owner
        self.repo = repo
        self.sessionManager = sessionManager
        self.responseQueue = responseQueue
    }

    // GET /repos/:owner/:repo/issues
    func fetchIssues() -> Single<[Issue]> {
        return sessionManager.request(baseURL, headers: headers).responseObjectForObservation(inResponseQueue: responseQueue, converter: { (httpURLResponse, data) -> [Issue] in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Issue].self, from: data)
        })
    }

    // GET /repos/:owner/:repo/issues/:number
    func fetchIssue(number: Int) -> Single<Issue> {
        return sessionManager.request(baseURL.appendingPathComponent(String(number)), headers: headers).responseObjectForObservation(inResponseQueue: responseQueue, converter: { (httpURLResponse, data) -> Issue in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Issue.self, from: data)
        })
    }
}
