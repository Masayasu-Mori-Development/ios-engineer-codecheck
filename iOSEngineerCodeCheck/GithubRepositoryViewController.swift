//
//  GithubRepositoryViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class GithubRepositoryViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var openIssuesLabel: UILabel!

    var vc1: SearchGithubRepositoryViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        let repository = vc1.repositories[vc1.idx]
        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        starsLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        openIssuesLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
    }

    func getImage() {
        let repo = vc1.repositories[vc1.idx]

        fullNameLabel.text = repo["full_name"] as? String

        if let owner = repo["owner"] as? [String: Any] {
            if let imgURLString = owner["avatar_url"] as? String,
               let imageURL = URL(string: imgURLString) {
                URLSession.shared.dataTask(with: imageURL) { (data, _, _) in
                    let img = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.avatarImageView.image = img
                    }
                }.resume()
            }
        }
    }
}
