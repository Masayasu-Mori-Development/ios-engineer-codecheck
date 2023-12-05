//
//  GithubRepositoryPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/05.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GithubRepositoryPresenterInput {
    var repository: [String: Any] { get }
}

final class GithubRepositoryPresenter: GithubRepositoryPresenterInput {
    private(set) var repository: [String: Any]
    
    init(repository: [String : Any]) {
        self.repository = repository
    }
}
