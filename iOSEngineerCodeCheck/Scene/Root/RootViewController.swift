//
//  RootViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 森勝康 on 2023/12/04.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    private var currentViewController: UIViewController?

    convenience init(currentViewController: UIViewController) {
        self.init()
        self.currentViewController = currentViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialViewController()
    }

    private func setupInitialViewController() {
        guard let currentViewController else {
            fatalError("currentViewController is Nil")
        }
        addChild(currentViewController)
        view.addSubview(currentViewController.view)
    }
}
