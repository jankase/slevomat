//
// Created by Jan Kase on 2018-10-12.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import SnapKit
import UIKit
import WebKit

class WebViewerView: UIViewController {

  var url: URL!
  weak var webView: WKWebView!

  override func loadView() {
    view = UIView(frame: UIScreen.main.bounds)
    view.backgroundColor = .white
    _loadWebView()
  }

  private func _loadWebView() {
    let theConfiguration = WKWebViewConfiguration()
    let theWebView = WKWebView(frame: .zero, configuration: theConfiguration)
    theWebView.load(URLRequest(url: url))
    view.addSubview(theWebView)
    theWebView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.left.equalToSuperview()
      $0.right.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }

}
