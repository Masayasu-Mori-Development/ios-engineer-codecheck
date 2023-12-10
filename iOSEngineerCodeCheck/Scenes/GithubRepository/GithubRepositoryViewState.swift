//
//  GithubRepositoryViewState.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/05.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

struct GithubRepositoryViewState {
    let fullName: String
    let language: String
    let stars: String
    let watchers: String
    let forks: String
    let openIssues: String
    let ownerAvatarUrl: String?
}

protocol GithubRepositoryViewStateBuilderProtocol {
    func build(repository: SearchGithubRepositoryDto) -> GithubRepositoryViewState
}

final class GithubRepositoryViewStateBuilder: GithubRepositoryViewStateBuilderProtocol {
    func build(repository: SearchGithubRepositoryDto) -> GithubRepositoryViewState {
        return .init(
            fullName: repository.fullName,
            language: "Written in \(repository.language)",
            stars: "\(repository.stargazersCount) stars",
            watchers: "\(repository.wachersCount) watchers",
            forks: "\(repository.forksCount) forks",
            openIssues: "\(repository.openIssuesCount) open issues",
            ownerAvatarUrl: repository.owner.avatarUrl
        )
    }
}
