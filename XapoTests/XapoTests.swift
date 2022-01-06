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
  
    private var cancellables = Set<AnyCancellable>()
    let dummyNetworkManagaer = DummyNetworkManger()
    var trendingGitHubListingMock = CurrentValueSubject<[GitHubModel],Never>([GitHubModel]())
    
    
    override func setUpWithError() throws {
      
        
        dummyNetworkManagaer.getData(endpoint: "", type: [GitHubModel].self)
            .sink { completiom in
                
            } receiveValue: { githubmodel in
                self.trendingGitHubListingMock.send(githubmodel)
                print("teting data",githubmodel)
            }
            .store(in: &cancellables)
    
    }
    
    
    func testGetData_WhenSucessResponse(){
        
        let githublist = GitHubListingViewModel(networkManager: dummyNetworkManagaer)
        
        XCTAssertEqual( githublist.trendingGitHubListing.value.count, 0)
        
        let promise = expectation(description: "start fetching github list")
        
        githublist.trendingGitHubListing
            .sink { completion in
                XCTFail()
            } receiveValue: { trendingList in
                print("tet printing -", trendingList)
                promise.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [promise], timeout: 0.5)
        
        
    }

    func testDataMocking(){
    
        XCTAssertEqual(trendingGitHubListingMock.value.count, 1)
        XCTAssertEqual(trendingGitHubListingMock.value[0].name, "jhon")
        XCTAssertEqual(trendingGitHubListingMock.value[0].author, "@jhon12")
        
    }
    
}
    
