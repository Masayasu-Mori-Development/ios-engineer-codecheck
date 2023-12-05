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
    private let githubRepositoryBuilder: any GithubRepositoryBuilderProtocol

    init(
        viewController: SearchGithubRepositoryViewController,
        githubRepositoryBuilder: any GithubRepositoryBuilderProtocol
    ) {
        self.viewController = viewController
        self.githubRepositoryBuilder = githubRepositoryBuilder
    }

    func transitionToGithubRepository(repository: [String: Any]) {
        let githubRepositoryVC = githubRepositoryBuilder.build(repository: repository)
        viewController?.navigationController?.pushViewController(githubRepositoryVC, animated: true)
    }
}
