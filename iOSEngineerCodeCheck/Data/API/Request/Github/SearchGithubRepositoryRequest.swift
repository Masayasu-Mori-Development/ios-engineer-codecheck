//
//  SearchGithubRepositoryRequest.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/09.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

struct SearchGithubRepositoryRequest: GithubAPIRequestProtocol {
    typealias ResponseType = Response

    var path: String {
        "/search/repositories"
    }

    var queryParameters: [QueryParameter] {
        parameters.map {
            .init(key: "q", value: $0.q)
        }
    }

    let parameters: [Parameter]

    // swiftlint:disable identifier_name
    // swiftlint:disable nesting
    struct Parameter: Encodable {
        let q: String
    }

    struct Response: Decodable {
        let items: [Item]

        struct Item: Decodable {
            let fullName: String?
            let language: String?
            let stargazersCount: Int?
            let wachersCount: Int?
            let forksCount: Int?
            let openIssuesCount: Int?
            let owner: Owner

            struct Owner: Decodable {
                let avatarUrl: String?
            }
        }
    }
    // swiftlint:enable nesting
    // swiftlint:enable identifier_name
}
