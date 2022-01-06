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
    
    
    // MARK: Outlets -
    
    @IBOutlet weak var gitHubListingTable: UITableView!
    
    // MARK: Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = " Trending List"
        
        gitHubListingTable.dataSource = self
        gitHubListingTable.delegate = self
        
        self.gitHubListingTable.register(UINib(nibName: "GitHubListCell", bundle: nil), forCellReuseIdentifier: CellConstants.reuseIdentifier)
        
        viewModel.getGitHubListing()
        
        viewModel.trendingGitHubListing
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.gitHubListingTable.reloadWithAnimation()
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
        
        let cell = gitHubListingTable.dequeueReusableCell(withIdentifier:  CellConstants.reuseIdentifier, for: indexPath) as! GitHubListCell
        
        viewModel.trendingGitHubListing
            .receive(on: RunLoop.main)
            .sink { gitHubModel in
                cell.configureCell(with: gitHubModel[indexPath.row])
            }
            .store(in: &cancellables)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let gitHubDetails = GitHubLinkDetails()
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.trendingGitHubListing
            .receive(on: RunLoop.main)
            .sink { githublistpass in
                gitHubDetails.githubDetails.send(githublistpass[indexPath.row])
                
            }
            .store(in: &cancellables)
        self.navigationController?.pushViewController(gitHubDetails, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}


