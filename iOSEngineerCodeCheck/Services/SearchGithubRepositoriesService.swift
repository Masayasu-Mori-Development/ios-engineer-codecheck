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

    init(githubRepository: GithubRepositoryProtocol = GithubRepository()) {
        self.githubRepository = githubRepository
    }

    func searchGithubRepositories(word: String) async throws -> [SearchGithubRepositoryDto] {
        guard word.isNotEmpty else {
            throw SearchGithubRepositoryError.wordIsEmpty
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
        githubRepository.cancelSearch()
    }

    enum SearchGithubRepositoryError: Error {
        case wordIsEmpty
    }
}
