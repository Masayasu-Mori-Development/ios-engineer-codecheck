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
        guard let viewState = presenter?.viewState else {
            return
        }
        fullNameLabel.text = viewState.fullName
        languageLabel.text = viewState.language
        starsLabel.text = viewState.stars
        watchersLabel.text = viewState.watchers
        forksLabel.text = viewState.forks
        openIssuesLabel.text = viewState.openIssues
    }
}
