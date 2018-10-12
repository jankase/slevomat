//
// Created by Jan Kase on 2018-10-12.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import UIKit

class WebViewerRouter {

  static var shared = WebViewerRouter()

  func defaultVc(url anUrl: URL) -> UIViewController {
    let theResult = WebViewerView()
    theResult.url = anUrl
    return theResult
  }

}
