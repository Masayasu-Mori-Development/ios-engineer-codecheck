//
//  GithubRepositoryMock.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 森勝康 on 2023/12/10.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
@testable import iOSEngineerCodeCheck

final class GithubRepositoryMock: GithubRepositoryProtocol {
    var cancelCallCount: Int = .zero
    
    func searchGithubRepositories(word: String) async throws -> iOSEngineerCodeCheck.SearchGithubRepositoryRequest.Response {
        .init(
            items: [
                .init(
                    fullName: "テスト太郎",
                    language: "Swift",
                    stargazersCount: 150,
                    wachersCount: 20,
                    forksCount: 40,
                    openIssuesCount: 10,
                    owner: .init(avatarUrl: nil)
                )
            ]
        )
    }
    
    func cancelSearch() {
        cancelCallCount += 1
    }
}
