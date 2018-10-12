//
// Created by Jan Kase on 2018-10-10.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Alamofire
import UIKit

class LoaderInteractor {

  static var shared = LoaderInteractor()

  var endPoint = "https://newsapi.org/v1/articles?source=techcrunch&sortBy=latest&apiKey=046fd2abc92149f69e8553cf34daad8b"
  //swiftlint:disable:previous line_length
  var queue = DispatchQueue(label: "NetworkLoader", qos: .default)

  func startLoading(interval anInterval: DispatchTimeInterval = .seconds(600)) {
    _timer?.cancel()
    _timer = DispatchSource.makeTimerSource(queue: queue)
    _timer?.schedule(deadline: .now(), repeating: anInterval)
    _timer?.setEventHandler { [weak self] in
      self?._loadServerData()
    }
    _timer?.resume()
  }

  func stopLoading() {
    _timer?.cancel()
    _timer = nil
  }

  private var _timer: DispatchSourceTimer?

  private func _loadServerData() {
    request(endPoint).responseData(queue: queue) { [weak self] aResponse in
      "Request: \(String(describing: aResponse.request))".log()
      "Response: \(String(describing: aResponse.response))".log()
      "Result: \(aResponse.result)".log()
      guard let theSelf = self, let theData = aResponse.result.value else {
        return
      }
      do {
        let theFeedJson = try JSONDecoder().decode(FeedJson.self, from: theData)
        "Processed \(theFeedJson.articles.count) article(s)".log()
        theSelf._store(articles: theFeedJson.articles)
      } catch let theError {
        "Failed JSON processing: \(theError)".log()
      }
    }
  }

  private func _store(articles anArticles: [Article]) {
    guard !anArticles.isEmpty else {
      return
    }
    do {
      let theLocalDb = try LocalDb.realm()
      try theLocalDb.write {
        anArticles.forEach {
          theLocalDb.add($0, update: true)
        }
      }
    } catch let theError {
      "Failed to store articles: \(theError)".log()
    }
  }

}
