//
//  GitHubListCell.swift
//  Xapo
//
//  Created by sabaz shereef on 31/12/21.
//

import UIKit
import SDWebImage
class GitHubListCell: UITableViewCell {

    @IBOutlet weak var gitHubImage: RoundedImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var gitHubName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(with gitHubModel: GitHubModel ){
        gitHubName.text = "GitHub Name: \(gitHubModel.name ?? "Github Name not available")"
        authorName.text = " Github Author\(gitHubModel.author ?? "Author Name not available")"
        gitHubImage.sd_setImage(with: URL(string: gitHubModel.avatar ?? ""), placeholderImage:UIImage(contentsOfFile:"PlaceholderImage"))
        
    }
}
