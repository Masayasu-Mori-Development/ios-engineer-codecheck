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

    func viewDidLoad()
}

@MainActor
protocol GithubRepositoryPresenterOutput: AnyObject {
    func updateAvatarImageView(data: Data)
}

final class GithubRepositoryPresenter: GithubRepositoryPresenterInput {
    private weak var viewController: GithubRepositoryPresenterOutput?
    private let getGithubAvatarImageDataService: GetGithubAvatarImageDataServiceProtocol
    private(set) var repository: [String: Any]

    init(
        viewController: GithubRepositoryPresenterOutput,
        getGithubAvatarImageDataService: GetGithubAvatarImageDataServiceProtocol,
        repository: [String: Any]
    ) {
        self.viewController = viewController
        self.getGithubAvatarImageDataService = getGithubAvatarImageDataService
        self.repository = repository
    }

    func viewDidLoad() {
        fetchAvatarImage()
    }

    private func fetchAvatarImage() {
        guard let owner = repository["owner"] as? [String: Any],
              let urlString = owner["avatar_url"] as? String else {
            return
        }
        Task.detached {
            do {
                let imageData = try await self.getGithubAvatarImageDataService.getAvatar(urlString: urlString)
                DispatchQueue.main.async {
                    self.viewController?.updateAvatarImageView(data: imageData)
                }
            } catch {
                guard let error = error as? GetGithubAvatarImageDataService.GetAvatarImageDataError else {
                    fatalError("error cannot cast to GetAvatarImageDataError")
                }
                switch error {
                case .cannotConvertToURL:
                    // TODO: Error handling
                    print("Cannot convert avatar url to URL")
                case .imageDataNotFound:
                    // TODO: Error handling
                    print("Failed get image data")
                }
            }
        }
    }
}
