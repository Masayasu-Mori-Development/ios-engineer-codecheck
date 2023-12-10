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
    private var repositories: [[String: Any]] = []
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
        Task.detached {
            do {
                let repositories = try await self.searchGithubRepositoriesService.searchGithubRepositories(
                    word: word ?? ""
                )
                self.repositories = repositories
                self.updateViewState()
                DispatchQueue.main.async {
                    self.viewController?.didSearchGithubRepositories()
                }
            } catch {
                guard let error = error as? SearchGithubRepositoriesService.SearchGithubRepositoryError else {
                    fatalError("error cannot cast to SearchGithubRepositoryError")
                }
                switch error {
                case .wordIsEmpty:
                    break
                case .cannotCreateUrl:
                    // TODO: errorHandling
                    print("Cannot create search github repository request url")
                case .requestFailed:
                    // TODO: errorHandling
                    print("Failed search github repository request")
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
