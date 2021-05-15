//
//  ConvertMiddleware.swift
//  ReMVVM
//
//  Created by Dariusz Grzeszczak on 14/05/2021.
//  Copyright © 2021 Dariusz Grzeszczak. All rights reserved.
//
/**

 Special type of middleware that converts one action to another. Source action will never be reduced.
 */
public protocol ConvertMiddleware: AnyMiddlewareConvertible {
    /// type of action handled by this Middleware
    associatedtype Action
    /// type of state handled by this Middleware
    associatedtype State

    /// Method will be called during dispatch process.
    /// - Parameters:
    ///   - state: current state in the store
    ///   - action: action that is dispatched
    ///   - dispatcher: allows to send completely new action. New action will goo through whole middleware stack.
    func onNext(for state: State, action: Action, dispatcher: Dispatcher)
}

extension ConvertMiddleware {

    /// AnyMiddleware factory
    public var any: AnyMiddleware {
        AnyMiddleware(middleware: self)
    }
}