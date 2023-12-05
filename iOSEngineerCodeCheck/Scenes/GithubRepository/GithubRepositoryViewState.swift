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
}

protocol GithubRepositoryViewStateBuilderProtocol {
    func build(repository: [String: Any]) -> GithubRepositoryViewState
}

final class GithubRepositoryViewStateBuilder: GithubRepositoryViewStateBuilderProtocol {
    func build(repository: [String: Any]) -> GithubRepositoryViewState {
        let fullName = repository["full_name"] as? String ?? ""
        let language = {
            let language = repository["language"] as? String ?? ""
            return "Written in \(language)"
        }()
        let stars = {
            let stars = repository["stargazers_count"] as? Int ?? .zero
            return "\(stars) stars"
        }()
        let watchers = {
            let wachersCount = repository["wachers_count"] as? Int ?? .zero
            return "\(wachersCount) watchers"
        }()
        let forks = {
            let forksCount = repository["forks_count"] as? Int ?? .zero
            return "\(forksCount) forks"
        }()
        let openIssues = {
            let openIssuesCount = repository["open_issues_count"] as? Int ?? .zero
            return "\(openIssuesCount) open issues"
        }()

        return .init(
            fullName: fullName,
            language: language,
            stars: stars,
            watchers: watchers,
            forks: forks,
            openIssues: openIssues
        )
    }
}
