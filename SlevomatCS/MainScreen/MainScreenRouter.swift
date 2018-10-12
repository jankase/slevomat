//
// Created by Jan Kase on 2018-10-11.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import UIKit

class MainScreenRouter: NSObject {

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
    theNavigationController.navigationBar.barStyle = .black
    theNavigationController.delegate = self
    return theNavigationController
  }

}

extension MainScreenRouter: UINavigationControllerDelegate {

  public func navigationController(_ aNavigationController: UINavigationController,
                                   willShow aViewController: UIViewController,
                                   animated anAnimated: Bool) {
    let theStatusBarBackground = UIView()
    theStatusBarBackground.backgroundColor = .black
    aViewController.view.addSubview(theStatusBarBackground)
    theStatusBarBackground.snp.makeConstraints {
      $0.left.equalToSuperview()
      $0.top.equalToSuperview()
      $0.right.equalToSuperview()
      $0.height.equalTo(UIApplication.shared.statusBarFrame.height)
    }
  }

}
