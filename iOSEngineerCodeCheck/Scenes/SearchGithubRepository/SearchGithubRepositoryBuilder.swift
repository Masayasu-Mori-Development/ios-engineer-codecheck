//
//  SearchGithubRepositoryBuilder.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/04.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol SearchGithubRepositoryBuilderProtocol {
    typealias ViewController = SearchGithubRepositoryViewController
    func build() -> ViewController
}

final class SearchGithubRepositoryBuilder: SearchGithubRepositoryBuilderProtocol {
    func build() -> ViewController {
        guard let viewController = UIStoryboard(
            name: "SearchGithubRepository",
            bundle: nil
        ).instantiateInitialViewController() as? ViewController else {
            fatalError("SearchGithubRepository is not found")
        }
        let searchGithubRepositoryService = SearchGithubRepositoryService()
        let presenter = SearchGithubRepositoryPresenter(
            viewController: viewController,
            router: SearchGithubRepositoryRouter(viewController: viewController),
            searchGithubRepositoryService: searchGithubRepositoryService
        )
        viewController.inject(presenter: presenter)

        return viewController
    }
}
