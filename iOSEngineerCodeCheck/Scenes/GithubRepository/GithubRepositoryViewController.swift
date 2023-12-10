//
//  GithubRepositoryViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class GithubRepositoryViewController: UIViewController, GithubRepositoryPresenterOutput {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var starsLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var openIssuesLabel: UILabel!

    private var presenter: GithubRepositoryPresenterInput?

    func inject(presenter: GithubRepositoryPresenterInput) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
}

private extension GithubRepositoryViewController {
    func setupView() {
        guard let viewState = presenter?.viewState else {
            return
        }
        if let ownerAvatarUrl = viewState.ownerAvatarUrl {
            avatarImageView.loadImage(with: ownerAvatarUrl)
        }
        fullNameLabel.text = viewState.fullName
        languageLabel.text = viewState.language
        starsLabel.text = viewState.stars
        watchersLabel.text = viewState.watchers
        forksLabel.text = viewState.forks
        openIssuesLabel.text = viewState.openIssues
    }
}
