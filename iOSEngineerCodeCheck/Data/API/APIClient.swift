//
//  APIClient.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/09.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import Combine

protocol APIClientProtocol {
    func request<T>(_ apiRequest: T) async throws -> T.ResponseType where T: APIRequestProtocol
    func cancel()
}

final class APIClient: APIClientProtocol {
    private var sessionTask: URLSessionTask?
    private var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    func request<T>(_ apiRequest: T) async throws -> T.ResponseType where T: APIRequestProtocol {
        let url = try createURL(request: apiRequest)

        return try await withCheckedThrowingContinuation { continuation in
            self.sessionTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
                if let data,
                   let responseData = try? self.jsonDecoder.decode(T.ResponseType.self, from: data) {
                    continuation.resume(returning: responseData)
                } else {
                    continuation.resume(throwing: APIError.requestFailed)
                }
            }
            self.sessionTask?.resume()
        }
    }

    func cancel() {
        sessionTask?.cancel()
    }

    private func createURL(request: any APIRequestProtocol) throws -> URL {
        guard var urlComponent = URLComponents(string: request.baseUrl + request.path) else {
            throw APIError.cannotCreateURL
        }
        urlComponent.queryItems = request.queryParameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        guard let url = urlComponent.url else {
            throw APIError.cannotCreateURL
        }
        return url
    }
}
