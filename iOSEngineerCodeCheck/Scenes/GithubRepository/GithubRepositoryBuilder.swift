//
//  GithubRepositoryBuilder.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/05.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GithubRepositoryBuilderProtocol: SceneBuilder
where ViewController == GithubRepositoryViewController {
    func build(repository: [String: Any]) -> ViewController
}

final class GithubRepositoryBuilder: GithubRepositoryBuilderProtocol {
    func build(repository: [String : Any]) -> ViewController {
        let viewController = defaultBuild()
        let presenter = GithubRepositoryPresenter(
            repository: repository
        )
        viewController.inject(presenter: presenter)

        return viewController
    }
}

