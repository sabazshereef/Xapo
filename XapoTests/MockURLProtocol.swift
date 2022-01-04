//
//  MockURLProtocol.swift
//  XapoTests
//
//  Created by sabaz shereef on 04/01/22.
//

import Foundation

class DummyNetworkManger : NetworkManagerProtocol {
    
    func getData<T>(type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        
        return Just(type as! T)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
  
}
