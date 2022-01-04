//
//  GitHubLinkDetails.swift
//  Xapo
//
//  Created by sabaz shereef on 02/01/22.
//

import UIKit
import Combine
import SDWebImage
class GitHubLinkDetails: UIViewController {
    
    // MARK: Variables -
    
    var githubDetails = PassthroughSubject<GitHubModel,Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Outlets -
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profileLink: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var projectDescription: UILabel!
    @IBOutlet weak var projectUrl: UILabel!
    @IBOutlet weak var projectStars: UILabel!
    @IBOutlet weak var projectForks: UILabel!
    
//MARK:  life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDetails()
    }
    
//MARK: Recieving data from table view -
    
    func getDetails() {
        githubDetails
            .sink { [weak self] githubData in
                self?.deployData(githubdata: githubData)
            }
            .store(in: &cancellables)
    }
// MARK: Deploying Data to Fields -
    
    func deployData(githubdata: GitHubModel){
        
        print(githubdata)
        userImage.sd_setImage(with: URL(string: githubdata.builtBy[0].avatar ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        
        self.username.text = "Username: \(githubdata.builtBy[0].username ?? "Username Empty")"
        self.profileLink.text = "Profile Link: \(githubdata.builtBy[0].href ?? "profile link empty")"
        self.authorName.text = "Author Name: \(githubdata.author ?? "Author not available")"
        self.projectDescription.text = "Description: \( githubdata.description ?? "description not availabble")"
        self.projectUrl.text = "Project Url: \(githubdata.url ?? "Url not available")"
        self.projectStars.text = "Rating: \(String(describing:githubdata.stars ?? 0))"
        self.projectForks.text = "Forks: \(String(describing:githubdata.forks ?? 0))"
    }
}
