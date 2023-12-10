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
    var githubRepositoryMock = GithubRepositoryMock()
    lazy var service: SearchGithubRepositoriesServiceProtocol = SearchGithubRepositoriesService(githubRepository: githubRepositoryMock)
    
    func test空文字で検索して空文字エラーが返ってくるか() async {
        do {
            let _ = try await service.searchGithubRepositories(word: "")
            XCTExpectFailure("空文字エラーが返ってこない")
        } catch {
            guard let searchError = error as? SearchGithubRepositoriesService.SearchGithubRepositoryError else {
                XCTExpectFailure("返ってくるエラーの変換に失敗")
                return
            }
            XCTAssertEqual(searchError, .wordIsEmpty)
        }
    }
    
    func test検索成功するか() async {
        do {
            let response = try await service.searchGithubRepositories(word: "Moya")
            XCTAssert(
                response[.zero].fullName == "テスト太郎" &&
                response[.zero].language == "Swift" &&
                response[.zero].stargazersCount == 150 &&
                response[.zero].wachersCount == 20 &&
                response[.zero].forksCount == 40 &&
                response[.zero].openIssuesCount == 10 &&
                response[.zero].owner.avatarUrl == nil
            )
        } catch {
            XCTExpectFailure("返ってくるエラーの変換に失敗")
        }
    }
    
    func testキャンセルが呼び出されているか() {
        service.cancelSearch()
        XCTAssertEqual(githubRepositoryMock.cancelCallCount, 1)
    }
}
