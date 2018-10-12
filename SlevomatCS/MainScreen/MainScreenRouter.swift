//
// Created by Jan Kase on 2018-10-11.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import UIKit

class MainScreenRouter {

  static var shared = MainScreenRouter()

  func defaultVc() -> UIViewController {
    let theResult = MainScreenView()
    let thePresenter = MainScreenPresenter()
    let theInteractor = MainScreenInteractor()

    theResult.presenter = thePresenter

    thePresenter.view = theResult
    thePresenter.interactor = theInteractor

    theInteractor.presenter = thePresenter

    return _setupNavigationController(rootVc: theResult)

  }

  private func _setupNavigationController(rootVc aRoutVc: UIViewController) -> UINavigationController {
    let theNavigationController = UINavigationController(rootViewController: aRoutVc)
    theNavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
    theNavigationController.navigationBar.shadowImage = UIImage()
    theNavigationController.navigationBar.isTranslucent = true
    return theNavigationController
  }

}
