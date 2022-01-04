//
//  NetworkManagerProtocol.swift
//  Xapo
//
//  Created by sabaz shereef on 04/01/22.
//

import Foundation
import Combine
protocol NetworkManagerProtocol {
    func getData<T: Decodable>(endpoint: String, type: T.Type) -> AnyPublisher<T, Error>
}
