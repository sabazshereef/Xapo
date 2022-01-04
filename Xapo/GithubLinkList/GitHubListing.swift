//
//  GitHubListing.swift
//  Xapo
//
//  Created by sabaz shereef on 31/12/21.
//

import UIKit
import Combine

class GitHubListing: UIViewController {
    
    // MARK: Variables -
    
    var viewModel = GitHubListingViewModel()
    private var cancellables = Set<AnyCancellable>()
    let reuseIdentifier = "Cell"
    
    // MARK: Outlets -
    
    @IBOutlet weak var gitHubListingTable: UITableView!
    
    // MARK: Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "GitHub Trending List"
        
        gitHubListingTable.dataSource = self
        gitHubListingTable.delegate = self
        
        self.gitHubListingTable.register(UINib(nibName: "GitHubListCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
      
        viewModel.getGitHubListing()
      
        viewModel.$trendingGitHubList
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.gitHubListingTable.reloadData()
            }
            .store(in: &cancellables)
        
    }
    
}
// MARK: Extension of GitHubListing for tableview data source and delegates -

extension GitHubListing: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = gitHubListingTable.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! GitHubListCell
        
        viewModel.$trendingGitHubList
            .receive(on: RunLoop.main)
            .sink { gitHubModel in
                if let gitHubModel = gitHubModel {
                    cell.configureCell(with: gitHubModel[indexPath.row])
                }
            }
            .store(in: &cancellables)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gitHubDetails = GitHubLinkDetails()
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.$trendingGitHubList
            .receive(on: RunLoop.main)
            .sink { githublist in
                if let githublist = githublist {
                    gitHubDetails.githubDetails.send(githublist[indexPath.row])
                }
            }
            .store(in: &cancellables)
        navigationController?.pushViewController(gitHubDetails, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}
