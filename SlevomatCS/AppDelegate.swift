//
//  AppDelegate.swift
//  SlevomatCS
//
//  Created by Jan Kase on 2018-10-09.
//  Copyright © 2018 Jan Kaše. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var loader: LoaderInteractor = .shared
  var mainRouter: MainScreenRouter = .shared

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    loader.startLoading()
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = mainRouter.defaultVc()
    window?.makeKeyAndVisible()
    return true
  }

}
