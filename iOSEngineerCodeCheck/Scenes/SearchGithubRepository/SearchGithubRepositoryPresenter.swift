//
//  SearchGithubRepositoryPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/04.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchGithubRepositoryPresenterInput {
    var repositories: [[String: Any]] { get }

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
    private let searchGithubRepositoryService: SearchGithubRepositoryServiceProtocol
    private(set) var repositories: [[String: Any]] = []

    init(
        viewController: SearchGithubRepositoryPresenterOutput,
        router: SearchGithubRepositoryRouterProtocol,
        searchGithubRepositoryService: SearchGithubRepositoryServiceProtocol
    ) {
        self.viewController = viewController
        self.router = router
        self.searchGithubRepositoryService = searchGithubRepositoryService
    }
}

extension SearchGithubRepositoryPresenter: SearchGithubRepositoryPresenterInput {
    func searchGithubRepositries(word: String?) {
        Task.detached {
            do {
                let repositories = try await self.searchGithubRepositoryService.searchGithubRepositories(
                    word: word ?? ""
                )
                self.repositories = repositories
                DispatchQueue.main.async {
                    self.viewController?.didSearchGithubRepositories()
                }
            } catch {
                guard let error = error as? SearchGithubRepositoryService.SearchGithubRepositoryError else {
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
        searchGithubRepositoryService.cancelSearch()
    }

    func didSelectRepository(row: Int) {
        let repository = repositories[row]
        router.transitionToGithubRepository(repository: repository)
    }
}