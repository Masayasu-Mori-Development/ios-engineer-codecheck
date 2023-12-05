//
//  SceneBuilder.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/04.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol SceneBuilder {
    associatedtype ViewController: UIViewController
    func build() -> ViewController
}

extension SceneBuilder {
    func build() -> ViewController {
        defaultBuild()
    }

    func defaultBuild() -> ViewController {
        let storyboardName = String(
            describing: ViewController.self
        ).replacingOccurrences(of: "ViewController", with: "")
        guard let viewController = UIStoryboard(
            name: storyboardName,
            bundle: nil
        ).instantiateInitialViewController() as? ViewController else {
            fatalError("\(storyboardName) not found")
        }
        return viewController
    }

    func navigationBuild(rootViewController: UIViewController) -> UINavigationController {
        return .init(rootViewController: rootViewController)
    }
}
