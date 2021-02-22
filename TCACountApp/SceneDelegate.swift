//
//  SceneDelegate.swift
//  TCACountApp
//
//  Created by 舘佳紀 on 2021/02/21.
//

import UIKit
import SwiftUI
import ComposableArchitecture

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.window = (scene as? UIWindowScene).map(UIWindow.init(windowScene:))
        let rootView = ContentView(
            store: Store(
                initialState: AppState(),
                reducer: appReducer,
                environment: AppEnvironment(
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                    numberFact: {
                        number in Effect(value: "\(number) is a good number Brent")
                    }
                )
            )
        )
        self.window?.rootViewController = UIHostingController(rootView: rootView)
        self.window?.makeKeyAndVisible()
    }
}

