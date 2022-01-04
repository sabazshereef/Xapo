//
//  HomePage.swift
//  Xapo
//
//  Created by sabaz shereef on 31/12/21.
//

import UIKit

class HomePage: UIViewController {
    
    // MARK: outlet -
    
    @IBOutlet weak var enterTheAppButton: RoundButton!
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterTheAppButton.backgroundColor = Colors.orangeButton
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Go To Xapo", style: .plain, target: self, action: #selector(goToXapo))
        navigationItem.rightBarButtonItem?.tintColor = Colors.whiteColor
    }
    
    // MARK: Navigation Button method -
    
    @objc func goToXapo() {
        NavigateToList()
    }
    // MARK: Button action -
    
    @IBAction func goToApp(_ sender: Any) {
        NavigateToList()
    }
    
    func NavigateToList() {
        let detailCarView = GitHubListing(nibName: "GitHubListing", bundle: nil)
        self.navigationController!.pushViewController(detailCarView, animated: true)
    }
    
}
