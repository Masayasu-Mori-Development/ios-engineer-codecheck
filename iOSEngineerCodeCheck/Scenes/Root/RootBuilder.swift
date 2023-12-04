//
//  RootBuilder.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/04.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol RootBuilderProtocol {
    func build() -> RootViewController
}

final class RootBuilder: RootBuilderProtocol {
    func build() -> RootViewController {
        return RootViewController(
            currentViewController: UINavigationController(
                rootViewController: SearchGithubRepositoryBuilder().build()
            )
        )
    }
}
