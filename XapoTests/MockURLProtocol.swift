//
//  MockURLProtocol.swift
//  XapoTests
//
//  Created by sabaz shereef on 04/01/22.
//

import Foundation
import Combine
@testable import Xapo

class DummyNetworkManger : NetworkManagerProtocol {
    
    func getData<T>(endpoint: String, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        return Future { promise in
            promise(.success([GitHubModel(author: "@jhon12", name: "jhon", avatar: "https://github.com/xingshaocheng.png", url: "https://github.com/xingshaocheng.png", description: "Container Runtime Sandbox", language: "Go", languageColor: "#3572A5", stars: 0, forks: 0, currentPeriodStars: 0, builtBy: [BuiltBy(href: "https://github.com/xingshaocheng.png", avatar: "https://github.com/xingshaocheng.png", username: "@jhon12")])] as! T))
        }.eraseToAnyPublisher()
        
        
    }
}
