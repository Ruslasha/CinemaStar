// AppDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,

        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        do {
            try KeychainService.instance.saveToken("WQT8GHV-ZYH45ES-PE33B08-KNRNHJ2", forKey: "TokenKP")
        } catch {
            print(error)
        }

//        urlRequest.setValue("WQT8GHV-ZYH45ES-PE33B08-KNRNHJ2", forHTTPHeaderField: "X-API-KEY")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,

        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(
        _ application: UIApplication,

        didDiscardSceneSessions sceneSessionsSet: Set<UISceneSession>
    ) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after
        // application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
