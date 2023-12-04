//
//  SceneDelegate.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private let rootBuilder: RootBuilderProtocol = RootBuilder()
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else {
            fatalError("WindowScene not found")
        }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.windowScene = windowScene
        self.window?.rootViewController = rootBuilder.build()
        self.window?.makeKeyAndVisible()
    }
}
