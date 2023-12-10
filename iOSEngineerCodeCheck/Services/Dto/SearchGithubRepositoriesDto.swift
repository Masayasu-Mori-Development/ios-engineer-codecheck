//
//  SearchGithubRepositoriesDto.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/10.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

struct SearchGithubRepositoriesDto {
    let repositories: [Repository]

    struct Repository {
        let fullName: String
        let language: String
        let stargazersCount: Int
        let wachersCount: Int
        let forksCount: Int
        let openIssuesCount: Int
        let owner: RepositoryOwner
    }

    struct RepositoryOwner {
        let avatarUrl: String?
    }
}
