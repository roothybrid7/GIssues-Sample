//
//  Context.swift
//  GIssues
//
//  Created by SATOSHI OKI on 12/19/18.
//

import Foundation

protocol ContextAware {
    associatedtype Context
    static var context: Context! { get }
    static func resolve<D>(keyPath: KeyPath<Context, D>) -> D
}

protocol ContextInstanceAware: ContextAware {
    var context: Context! { get }
    func resolve<D>(keyPath: KeyPath<Context, D>) -> D
}

extension ContextAware {

    static func resolve<D>(keyPath: KeyPath<Context, D>) -> D {
        return context[keyPath: keyPath]
    }
}

extension ContextInstanceAware {

    var context: Context! {
        return type(of: self).context
    }

    func resolve<D>(keyPath: KeyPath<Context, D>) -> D {
        return type(of: self).resolve(keyPath: keyPath)
    }
}
