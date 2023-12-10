//
//  SearchGithubRepositoriesService.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/04.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchGithubRepositoriesServiceProtocol {
    func searchGithubRepositories(word: String) async throws -> [SearchGithubRepositoryDto]
    func cancelSearch()
}

final class SearchGithubRepositoriesService: SearchGithubRepositoriesServiceProtocol {
    private let githubRepository: GithubRepositoryProtocol
    private var sessionTask: URLSessionTask?

    init(githubRepository: GithubRepositoryProtocol = GithubRepository()) {
        self.githubRepository = githubRepository
    }

    func searchGithubRepositories(word: String) async throws -> [SearchGithubRepositoryDto] {
        guard word.isNotEmpty else {
            throw SearchGithubRepositoryError.wordIsEmpty
        }
        guard let url = createUrl(word: word) else {
            throw SearchGithubRepositoryError.cannotCreateUrl
        }
        do {
            let response = try await githubRepository.searchGithubRepositories(word: word)
            return response.items.map { item in
                return .init(
                    fullName: item.fullName ?? "",
                    language: item.language ?? "",
                    stargazersCount: item.stargazersCount ?? .zero,
                    wachersCount: item.wachersCount ?? .zero,
                    forksCount: item.forksCount ?? .zero,
                    openIssuesCount: item.openIssuesCount ?? .zero,
                    owner: .init(avatarUrl: item.owner.avatarUrl)
                )
            }
        } catch {
            throw error
        }
    }

    func cancelSearch() {
        sessionTask?.cancel()
    }

    private func createUrl(word: String) -> URL? {
        let urlString = "https://api.github.com/search/repositories"
        let wordQueryName = "q"
        guard let url = URL(string: urlString) else {
            return nil
        }
        var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: url.baseURL != nil)
        urlComponent?.queryItems = [
            .init(name: wordQueryName, value: word)
        ]
        return urlComponent?.url
    }

    enum SearchGithubRepositoryError: Error {
        case wordIsEmpty, cannotCreateUrl, requestFailed
    }
}
