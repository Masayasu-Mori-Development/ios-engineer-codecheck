//
//  APIRequestProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/09.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol APIRequestProtocol {
    associatedtype ResponseType: Decodable

    var baseUrl: String { get }
    var path: String { get }
    var queryParameters: [QueryParameter] { get }
}

struct QueryParameter {
    let key: String
    let value: String
}
