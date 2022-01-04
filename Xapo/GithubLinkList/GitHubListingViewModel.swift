//
//  GitHubListingViewModel.swift
//  Xapo
//
//  Created by sabaz shereef on 01/01/22.
//

import Foundation
import Combine
class GitHubListingViewModel {
    
    //MARK: variables -
    
    @Published var trendingGitHubList : [GitHubModel]?
    private var cancellables = Set<AnyCancellable>()
    var networkManager : NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    // MARK: Fetching response from API -
    
    func getGitHubListing() {
        networkManager.getData( endpoint: Endpoint.githubs, type: [GitHubModel].self)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                  
                case .finished:
                    print("Finished")
                }
            }
    receiveValue: { [weak self] githubList in
        self?.trendingGitHubList = githubList
    }
    .store(in: &cancellables)
    }
    
    // MARK: - total count to display in table view-
    
    func getListCount() -> Int {
        
        return trendingGitHubList?.count ?? 0
    }
    // MARK: - github name to display in table view-
    
    func getGitHubName(index: Int) -> String{
        return trendingGitHubList?[index].name ?? "Github Name Not Available"
    }
    // MARK: - Author name to display in table view-
    
    func getAuthorName(index: Int) -> String{
        return trendingGitHubList?[index].author ?? "Author Name Not Available"
    }
    
    
}

