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

    private var presenter: GithubRepositoryPresenterInput?

    func inject(presenter: GithubRepositoryPresenterInput) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        presenter?.viewDidLoad()
    }
}

// MARK: - GithubRepositoryPresenterOutput
extension GithubRepositoryViewController: GithubRepositoryPresenterOutput {
    func updateAvatarImageView(data: Data) {
        guard let image = UIImage(data: data) else {
            return
        }
        avatarImageView.image = image
    }
}

private extension GithubRepositoryViewController {
    func setupView() {
        guard let repository = presenter?.repository else {
            return
        }
        fullNameLabel.text = repository["full_name"] as? String
        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        starsLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        openIssuesLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
    }
}
