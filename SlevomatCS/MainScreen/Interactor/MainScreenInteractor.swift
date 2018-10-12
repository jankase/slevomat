//
// Created by Jan Kase on 2018-10-12.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation

class MainScreenInteractor {

  weak var presenter: MainScreenPresenter!

  func loadArticles() {
    do {
      let theLocalDb = try LocalDb.realm()
      let theResult = theLocalDb.objects(Article.self).sorted(byKeyPath: "publishDate", ascending: false)
      presenter.setArticlesToShow(theResult)
    } catch let theError {
      "Failed to open local db: \(theError)".log()
    }
  }

}
