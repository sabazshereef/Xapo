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
    
   // @Published var trendingGitHubList : [GitHubModel]?
    var trendingGitHubListing = CurrentValueSubject<[GitHubModel],Never>([GitHubModel]())
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
       // self?.trendingGitHubList = githubList
        self?.trendingGitHubListing.send(githubList)
    }
    .store(in: &cancellables)
    }
    
    // MARK: - total count to display in table view-
    
    func getListCount() -> Int {
        
        return trendingGitHubListing.value.count
    }
    // MARK: - github name to display in table view-
    
    func getGitHubName(index: Int) -> String{
      
        return trendingGitHubListing.value[index].name ?? "GitHub Name"
    }
    // MARK: - Author name to display in table view-
    
    func getAuthorName(index: Int) -> String{
       
        return trendingGitHubListing.value[index].author ?? "Author Name Not Available"
    }
    
    
}

