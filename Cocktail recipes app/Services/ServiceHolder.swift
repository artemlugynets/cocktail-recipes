//
//  ServiceHolder.swift
//
//  Created by Denis Senichkin on 16.12.2021.
//

import Foundation

public protocol Service {}

public class ServiceHolder {
    private var servicesDictionary: [String: Service] = [:]
    
    static var shared: ServiceHolder = {
        let instance = ServiceHolder()
        return instance
    }()
    
    private init() {}
    
    func add<T>(_ protocolType: T.Type, for instance: Service) {
        let name = String(reflecting: protocolType)
        servicesDictionary[name] = instance
    }
    
    func get<T>(by type: T.Type = T.self) -> T {
        return get(by: String(reflecting: type))
    }
    
    func remove<T>(by type: T.Type) {
        let name = String(reflecting: type)
        if let _ = servicesDictionary[name] as? T {
            servicesDictionary[name] = nil
        }
    }

    private func get<T>(by name: String) -> T {
        guard let service = servicesDictionary[name] as? T else {
            fatalError("Firstly you have to add the service")
        }
        return service
    }
}
