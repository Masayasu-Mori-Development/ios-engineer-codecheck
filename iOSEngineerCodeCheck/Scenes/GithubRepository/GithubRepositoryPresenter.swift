//
//  GithubRepositoryPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/05.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GithubRepositoryPresenterInput {
    var viewState: GithubRepositoryViewState { get }
}

@MainActor
protocol GithubRepositoryPresenterOutput: AnyObject {
}

final class GithubRepositoryPresenter: GithubRepositoryPresenterInput {
    private weak var viewController: GithubRepositoryPresenterOutput?
    private let getGithubAvatarImageDataService: GetGithubAvatarImageDataServiceProtocol
    private let viewStateBuilder: GithubRepositoryViewStateBuilderProtocol
    private let repository: SearchGithubRepositoryDto
    private(set) var viewState: GithubRepositoryViewState

    init(
        viewController: GithubRepositoryPresenterOutput,
        getGithubAvatarImageDataService: GetGithubAvatarImageDataServiceProtocol,
        viewStateBuilder: GithubRepositoryViewStateBuilderProtocol,
        repository: SearchGithubRepositoryDto
    ) {
        self.viewController = viewController
        self.getGithubAvatarImageDataService = getGithubAvatarImageDataService
        self.viewStateBuilder = viewStateBuilder
        self.repository = repository
        self.viewState = viewStateBuilder.build(repository: repository)
    }
}
