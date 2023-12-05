//
//  SearchGithubRepositoryViewState.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/05.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

struct SearchGithubRepositoryViewState {
    let cells: [SearchGithubRepositoryTableViewCellState]
}

protocol SearchGithubRepositoryViewStateBuilderProtocol {
    func build(repositories: [[String: Any]]) -> SearchGithubRepositoryViewState
}

final class SearchGithubRepositoryViewStateBuilder: SearchGithubRepositoryViewStateBuilderProtocol {
    func build(repositories: [[String: Any]]) -> SearchGithubRepositoryViewState {
        .init(
            cells: repositories.map { repository in
                return .init(
                    fullName: repository["full_name"] as? String ?? "",
                    language: repository["language"] as? String ?? ""
                )
            }
        )
    }
}
