//
//  GithubAPIRequestProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/09.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GithubAPIRequestProtocol: APIRequestProtocol {
}

extension GithubAPIRequestProtocol {
    var baseUrl: String {
        "https://api.github.com"
    }
}
