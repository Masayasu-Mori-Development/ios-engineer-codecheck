//
//  SearchGithubRepositoryBuilder.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/04.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol SearchGithubRepositoryBuilderProtocol: SceneBuilder
where ViewController == SearchGithubRepositoryViewController {
}

final class SearchGithubRepositoryBuilder: SearchGithubRepositoryBuilderProtocol {
    func build() -> SearchGithubRepositoryViewController {
        let viewController = defaultBuild()
        let presenter = SearchGithubRepositoryPresenter(
            viewController: viewController,
            router: SearchGithubRepositoryRouter(
                viewController: viewController,
                githubRepositoryBuilder: GithubRepositoryBuilder()
            ),
            searchGithubRepositoriesService: SearchGithubRepositoriesService(),
            viewStateBuilder: SearchGithubRepositoryViewStateBuilder()
        )
        viewController.inject(presenter: presenter)

        return viewController
    }
}
