//
//  AppContext.swift
//  GIssues
//
//  Created by SATOSHI OKI on 12/19/18.
//

import Foundation
import Domain
import Infra

final class AppContext {

    static var `default` = AppContext()

    private let useCaseResolver: Domain.UseCaseResolver
    let viewModelProvider: ViewModelProvider

    init() {
        let useCaseResolver = Infra.UseCaseResolver(config: Config(endpoint: "https://api.github.com", owner: "golang", repo: "go"))
        self.useCaseResolver = useCaseResolver
        self.viewModelProvider = ViewModelProvider(useCaseResolver: useCaseResolver)
    }
}

extension ContextAware where Context == AppContext {

    static var context: Context! {
        return AppContext.default
    }
}
