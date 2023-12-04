//
//  SearchGithubRepositoryRouter.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/04.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol SearchGithubRepositoryRouterProtocol {
    func transitionToGithubRepository(repository: [String: Any])
}

final class SearchGithubRepositoryRouter: SearchGithubRepositoryRouterProtocol {
    private weak var viewController: SearchGithubRepositoryViewController?

    init(viewController: SearchGithubRepositoryViewController) {
        self.viewController = viewController
    }

    func transitionToGithubRepository(repository: [String: Any]) {
        guard let githubRepositoryVC = UIStoryboard(
            name: "GithubRepository",
            bundle: nil
        ).instantiateInitialViewController() as? GithubRepositoryViewController else {
            fatalError("Not found GithubRepositoryViewController")
        }
        githubRepositoryVC.repository = repository
        viewController?.navigationController?.pushViewController(githubRepositoryVC, animated: true)
    }
}
