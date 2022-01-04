//
//  XapoTests.swift
//  XapoTests
//
//  Created by sabaz shereef on 31/12/21.
//

import XCTest
import Combine
@testable import Xapo

class XapoTests: XCTestCase {
    
    var sut: NetworkManager!
    @Published var trendingGitHubList : [GitHubModel]?
    private var cancellables = Set<AnyCancellable>()
    let dummyNetworkManagaer = DummyNetworkManger()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut = NetworkManager(urlSession: urlSession)
        
    }
    
    
    func testGetData_WhenSucessResponse(){
        
        let dummyNetworkManagaer = DummyNetworkManger()
        let githublist = GitHubListingViewModel(networkManager: dummyNetworkManagaer)
        
        XCTAssertEqual( githublist.trendingGitHubList?.count, nil)
        
        let promise = expectation(description: "start fetching github list")
        
        githublist.$trendingGitHubList
            .sink { completion in
                XCTFail()
            } receiveValue: { trendingList in
                
                promise.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [promise], timeout: 0.5)
        

        
    }


    
