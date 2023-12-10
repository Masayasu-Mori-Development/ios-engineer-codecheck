//
//  GithubRepository.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/09.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GithubRepositoryProtocol {
    func searchGithubRepositories(word: String) async throws -> SearchGithubRepositoryRequest.Response
    func cancelSearch()
}

final class GithubRepository: GithubRepositoryProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func searchGithubRepositories(word: String) async throws -> SearchGithubRepositoryRequest.Response {
        let request = SearchGithubRepositoryRequest(parameters: [.init(q: word)])
        return try await apiClient.request(request)
    }
    
    func cancelSearch() {
        apiClient.cancel()
    }
}
