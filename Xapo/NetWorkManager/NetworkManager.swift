//
//  NetworkManager.swift
//  Xapo
//
//  Created by sabaz shereef on 31/12/21.
//

import Foundation
import Combine


class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Variables
    
    private var cancellables = Set<AnyCancellable>()
    var session : URLSession
    
    init(urlSession: URLSession = .shared) {
        self.session = urlSession
    }
    
    // MARK: - Fetching Data
    
    func getData<T: Decodable>(endpoint: String, type: T.Type) -> AnyPublisher<T, Error> {
        
        return Future<T, Error> { [weak self] promise in
            guard let self = self, let url = URL(string: endpoint) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            print("URL is \(url.absoluteString)")
            //change
            self.session.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                           
                        }
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)
        }
        .eraseToAnyPublisher()
    }
}
