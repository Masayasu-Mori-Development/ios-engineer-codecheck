//
//  GetGithubAvatarImageDataService.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/05.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GetGithubAvatarImageDataServiceProtocol {
    func getAvatar(urlString: String) async throws -> Data
}

final class GetGithubAvatarImageDataService: GetGithubAvatarImageDataServiceProtocol {
    func getAvatar(urlString: String) async throws -> Data {
        guard let imageURL = URL(string: urlString) else {
            throw GetAvatarImageDataError.cannotConvertToURL
        }
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: imageURL) { (data, _, _) in
                if let data {
                    continuation.resume(returning: data)
                } else {
                    continuation.resume(throwing: GetAvatarImageDataError.imageDataNotFound)
                }
            }.resume()
        }
    }

    enum GetAvatarImageDataError: Error {
        case cannotConvertToURL, imageDataNotFound
    }
}
