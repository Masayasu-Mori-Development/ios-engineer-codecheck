//
//  SearchGithubRepositoryServiceTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 森勝康 on 2023/12/09.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

class SearchGithubRepositoryServiceTests: XCTestCase {
    let service = SearchGithubRepositoryService()
    
    func test空文字で検索してエラーが返ってくるか() async {
        do {
            let _ = try await service.searchGithubRepositories(word: "")
        } catch {
            guard let searchError = error as? SearchGithubRepositoryService.SearchGithubRepositoryError else {
                XCTExpectFailure("")
                return
            }
            XCTAssertEqual(searchError, .wordIsEmpty)
        }
    }
}
