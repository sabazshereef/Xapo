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
    var githubDetails = CurrentValueSubject<GitHubModel, Never>(GitHubModel(author: "No Data available", name: "No Data available", avatar: "No Data available", url: "No Data available", description: "No Data available", language: "No Data available", languageColor: "No Data available", stars: 0, forks: 0, currentPeriodStars: 0, builtBy: [BuiltBy(href: "No Data available", avatar: "No Data available", username: "No Data available")]))
    private var cancellables = Set<AnyCancellable>()
    var Indexing = Int()
    
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
            .sink{[weak self ] github in
              
                self?.deployData(githubdata: github)
            }
            .store(in: &cancellables)
        
    }
// MARK: Deploying Data to Fields -
    
    func deployData(githubdata: GitHubModel){
        
        userImage.sd_setImage(with: URL(string: githubdata.builtBy[0].avatar ?? ""), placeholderImage:UIImage(contentsOfFile:"PlaceholderImage"))
        
        self.username.text = "Username: \(githubdata.builtBy[0].username ?? "Username Empty")"
        self.profileLink.text = "Profile Link: \(githubdata.builtBy[0].href ?? "profile link empty")"
        self.authorName.text = "Author Name: \(githubdata.author ?? "Author not available")"
        self.projectDescription.text = "Description: \( githubdata.description ?? "description not availabble")"
        self.projectUrl.text = "Project Url: \(githubdata.url ?? "Url not available")"
        self.projectStars.text = "Rating: \(String(describing:githubdata.stars ?? 0))"
        self.projectForks.text = "Forks: \(String(describing:githubdata.forks ?? 0))"
    }
}
