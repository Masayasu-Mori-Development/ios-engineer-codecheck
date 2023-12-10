//
//  SearchGithubRepositoryPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/04.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchGithubRepositoryPresenterInput {
    var viewState: SearchGithubRepositoryViewState? { get }

    func searchGithubRepositries(word: String?)
    func searchTextDidChange()
    func didSelectRepository(row: Int)
}

@MainActor
protocol SearchGithubRepositoryPresenterOutput: AnyObject {
    func didSearchGithubRepositories()
}

final class SearchGithubRepositoryPresenter {
    private weak var viewController: SearchGithubRepositoryPresenterOutput?
    private let router: SearchGithubRepositoryRouterProtocol
    private let searchGithubRepositoriesService: SearchGithubRepositoriesServiceProtocol
    private let viewStateBuilder: SearchGithubRepositoryViewStateBuilderProtocol
    private var repositories: [SearchGithubRepositoryDto] = []
    private(set) var viewState: SearchGithubRepositoryViewState?

    init(
        viewController: SearchGithubRepositoryPresenterOutput,
        router: SearchGithubRepositoryRouterProtocol,
        searchGithubRepositoriesService: SearchGithubRepositoriesServiceProtocol,
        viewStateBuilder: SearchGithubRepositoryViewStateBuilderProtocol
    ) {
        self.viewController = viewController
        self.router = router
        self.searchGithubRepositoriesService = searchGithubRepositoriesService
        self.viewStateBuilder = viewStateBuilder
    }
}

extension SearchGithubRepositoryPresenter: SearchGithubRepositoryPresenterInput {
    func searchGithubRepositries(word: String?) {
        guard let word else {
            return
        }
        Task.detached {
            do {
                let repositories = try await self.searchGithubRepositoriesService.searchGithubRepositories(
                    word: word
                )
                self.repositories = repositories
                self.updateViewState()
                DispatchQueue.main.async {
                    self.viewController?.didSearchGithubRepositories()
                }
            } catch {
                if let error = error as? APIError {
                    switch error {
                    case .cannotCreateURL:
                        print("Cannot create SearchGithubRepositories URL")
                    case .requestFailed:
                        print("Failed search github repositories API")
                    }
                }
            }
        }
    }

    func searchTextDidChange() {
        searchGithubRepositoriesService.cancelSearch()
    }

    func didSelectRepository(row: Int) {
        let repository = repositories[row]
        router.transitionToGithubRepository(repository: repository)
    }
}

private extension SearchGithubRepositoryPresenter {
    func updateViewState() {
        viewState = viewStateBuilder.build(repositories: repositories)
    }
}
