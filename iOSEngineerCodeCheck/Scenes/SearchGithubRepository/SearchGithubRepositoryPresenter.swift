//
//  SearchGithubRepositoryPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/04.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchGithubRepositoryPresenterInput {
    func searchGithubRepositries(word: String)
    func searchTextDidChange()
    func didSelectRepository(row: Int)
}

@MainActor
protocol SearchGithubRepositoryPresenterOutput: AnyObject {
    func didSearchGithubRepositories(_ repositories: [[String: Any]])
}

final class SearchGithubRepositoryPresenter {
    private weak var viewController: SearchGithubRepositoryPresenterOutput?
    private let router: SearchGithubRepositoryRouterProtocol
    private let searchGithubRepositoryService: SearchGithubRepositoryServiceProtocol

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
    func searchGithubRepositries(word: String) {
        Task.detached {
            do {
                let repositories = try await self.searchGithubRepositoryService.searchGithubRepositories(word: word)
                DispatchQueue.main.async {
                    self.viewController?.didSearchGithubRepositories(repositories)
                }
            } catch {
                guard let error = error as? SearchGithubRepositoryService.SearchGithubRepositoryError else {
                    return
                }
                return
            }
        }
    }

    func searchTextDidChange() {
        searchGithubRepositoryService.cancelSearch()
    }

    func didSelectRepository(row: Int) {
        router.transitionToGithubRepository()
    }
}
