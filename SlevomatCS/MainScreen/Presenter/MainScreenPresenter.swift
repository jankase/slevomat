//
// Created by Jan Kase on 2018-10-12.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import RealmSwift
import UIKit

class MainScreenPresenter {

  weak var view: MainScreenView!

  var interactor: MainScreenInteractor!
  var listDateFormatter: DateFormatter = {
    let theDateFormatter = DateFormatter()
    theDateFormatter.timeStyle = .short
    theDateFormatter.dateStyle = .short
    theDateFormatter.locale = Locale(identifier: "cs_CZ")
    theDateFormatter.doesRelativeDateFormatting = true
    return theDateFormatter
  }()

  var numberOfArticles: Int {
    return _articles?.count ?? 0
  }

  func loadArticles() {
    interactor.loadArticles()
  }

  func title(indexPath anIndexPath: IndexPath) -> String {
    return _article(for: anIndexPath).title
  }

  func listDate(indexPath anIndexPath: IndexPath) -> String {
    return listDateFormatter.string(from: _article(for: anIndexPath).publishDate)
  }

  func listImage(indexPath anIndexPath: IndexPath) -> UIImage? {
    guard let theImageData = _article(for: anIndexPath).imageData else {
      return nil
    }
    let theScreen = UIScreen.main
    let theImageWidth = theScreen.defaultRounding.round(value: theScreen.bounds.width / 5.0)
    return UIImage(data: theImageData)?.square(maxDimension: theImageWidth)
  }

  func setArticlesToShow(_ anArticles: Results<Article>) {
    _articles = anArticles
    _updateNotificationToken = _articles?.observe { [weak self] aChange in
      guard let theSelf = self else {
        return
      }
      switch aChange {
      case .initial:
        theSelf.view.shouldReloadArticles()
      case let .update(_, theDeleted, theInserted, theUpdated):
        let theIndexPathMap: (Int) -> IndexPath = { IndexPath(row: $0, section: 0) }
        theSelf.view.performUpdates(deletions: theDeleted.map(theIndexPathMap),
                                    insertion: theInserted.map(theIndexPathMap),
                                    updates: theUpdated.map(theIndexPathMap))
      case .error(let theError):
        "Realm notification failed: \(theError)".log()
      }
    }
  }

  private func _article(for anIndexPath: IndexPath) -> Article {
    guard let theArticles = _articles, anIndexPath.row < theArticles.count else {
      fatalError("Data not available for index")
    }
    return theArticles[anIndexPath.row]
  }

  private var _articles: Results<Article>?
  private var _updateNotificationToken: NotificationToken?

}
