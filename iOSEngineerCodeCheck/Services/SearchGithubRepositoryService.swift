//
//  SearchGithubRepositoryService.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/04.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchGithubRepositoryServiceProtocol {
    func searchGithubRepositories(word: String) async throws -> [[String: Any]]
    func cancelSearch()
}

final class SearchGithubRepositoryService: SearchGithubRepositoryServiceProtocol {
    private var sessionTask: URLSessionTask?

    func searchGithubRepositories(word: String) async throws -> [[String: Any]] {
        guard word.isNotEmpty else {
            throw SearchGithubRepositoryError.wordIsEmpty
        }
        guard let url = createUrl(word: word) else {
            throw SearchGithubRepositoryError.cannotCreateUrl
        }
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            self?.sessionTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
                if let obj = try? JSONSerialization.jsonObject(with: data!) as? [String: Any],
                   let items = obj["items"] as? [[String: Any]] {
                    continuation.resume(returning: items)
                } else {
                    continuation.resume(throwing: SearchGithubRepositoryError.requestFailed)
                }
            }
            self?.sessionTask?.resume()
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
