//
//  ReDispatcher.swift
//  
//
//  Created by Dariusz Grzeszczak on 22/04/2021.
//
#if swift(>=5.1) && canImport(SwiftUI) && canImport(Combine)
import Combine
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@propertyWrapper
public struct SourcedDispatcher: DynamicProperty {

    @Environment(\.storeContainer) var storeContainer
    private(set) var wrapper: Wrapper
    public var wrappedValue: Dispatcher { wrapper }

    class Wrapper: EmptyStoreUpdatable, Dispatcher {
        func dispatch(action: StoreAction) {
            store.dispatch(action: action)
        }
    }

    public init() {
        wrapper = .init(store: StoreAndViewModelProvider.empty.store)
        wrapper.update(store: storeContainer.store)
    }

    public func update() {
        wrapper.update(store: storeContainer.store)
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SourcedDispatcher: StoreUpdatable {
    func update(store:  Dispatcher & Source & AnyStateProvider) {
        wrapper.update(store: store)
    }
}

#endif
