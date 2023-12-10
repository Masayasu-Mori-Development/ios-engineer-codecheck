//
//  SearchGithubRepositoryDto.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/10.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

struct SearchGithubRepositoryDto {
    let fullName: String
    let language: String
    let stargazersCount: Int
    let wachersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let owner: Owner

    struct Owner {
        let avatarUrl: String?
    }
}
