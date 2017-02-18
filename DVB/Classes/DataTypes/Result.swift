//
//  Result.swift
//  Pods
//
//  Created by Kilian Költzsch on 06/05/16.
//
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)

    init(success x: Value) {
        self = .success(x)
    }

    init(failure x: Error) {
        self = .failure(x)
    }

    public func get() throws -> Value {
        switch self {
        case .success(let x): return x
        case .failure(let e): throw e
        }
    }

    public var success: Value? {
        switch self {
        case .success(let x): return x
        case .failure(_): return nil
        }
    }

    public var failure: Error? {
        switch self {
        case .success(_): return nil
        case .failure(let e): return e
        }
    }
}

public func ?? <T>(result: Result<T>, defaultValue: @autoclosure () -> T) -> T {
    switch result {
    case .success(let x): return x
    case .failure(_): return defaultValue()
    }
}
