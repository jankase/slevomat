//
// Created by Jan Kase on 2018-10-12.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import RealmSwift
import UIKit

class MainScreenPresenter {

  weak var view: MainScreenView!

  var interactor: MainScreenInteractor!
  var currentArticle: Article? {
    didSet {
      view.updateCurrentDescription(currentArticle?.desc)
      let theScreen = UIScreen.main
      let theImage = currentArticle?.image?
          .square(maxDimension: theScreen.defaultRounding.round(value: theScreen.bounds.width / 3.0))
      view.updateCurrentImage(theImage)
      var authorAndDateSegments: [String] = []
      if let theAuthor = currentArticle?.author {
        authorAndDateSegments.append(theAuthor)
      }
      if let thePublishDate = currentArticle?.publishDate {
        authorAndDateSegments.append(detailDateFormatter.string(from: thePublishDate))
      }
      if authorAndDateSegments.isEmpty {
        view.updateCurrentAuthorNameAndPublishDate(nil)
      } else {
        view.updateCurrentAuthorNameAndPublishDate(authorAndDateSegments.joined(separator: ", "))
      }
      view.updateCurrentTitle(currentArticle?.title)
      if currentArticle == nil {
        view.hideShareButton()
      } else {
        view.showShareButton()
      }
    }
  }

  var numberOfArticles: Int {
    return _articles?.count ?? 0
  }

  var listDateFormatter: DateFormatter = {
    let theDateFormatter = DateFormatter()
    theDateFormatter.timeStyle = .short
    theDateFormatter.dateStyle = .short
    theDateFormatter.locale = Locale.autoupdatingCurrent
    theDateFormatter.doesRelativeDateFormatting = true
    return theDateFormatter
  }()

  var detailDateFormatter: DateFormatter = {
    let theDateFormatter = DateFormatter()
    let theFormatterLocale = Locale(identifier: "cs_CZ")
    theDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "HHmmddMMMMYYYY",
                                                           options: 0,
                                                           locale: theFormatterLocale)
    theDateFormatter.locale = theFormatterLocale
    return theDateFormatter
  }()

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
    if currentArticle == nil {
      currentArticle = anArticles.first
    } else if anArticles.isEmpty {
      currentArticle = nil
    }
    _updateNotificationToken = _articles?.observe { [weak self] aChange in
      guard let theSelf = self else {
        return
      }
      switch aChange {
      case .initial:
        theSelf.view.shouldReloadArticles()
      case let .update(theArticles, theDeleted, theInserted, theUpdated):
        let theIndexPathMap: (Int) -> IndexPath = { IndexPath(row: $0, section: 0) }
        theSelf.view.performUpdates(deletions: theDeleted.map(theIndexPathMap),
                                    insertion: theInserted.map(theIndexPathMap),
                                    updates: theUpdated.map(theIndexPathMap))
        if theSelf.currentArticle == nil ||
               !theArticles.contains(where: { $0.internalUrl == theSelf.currentArticle!.internalUrl }) {
          theSelf.currentArticle = theArticles.first
        } else if let theCurrentArticleIndex =
        theArticles.firstIndex(where: { $0.internalUrl == theSelf.currentArticle!.internalUrl }),
                  theUpdated.contains(theCurrentArticleIndex) {
          theSelf.currentArticle = theArticles[theCurrentArticleIndex]
        }
      case .error(let theError):
        "Realm notification failed: \(theError)".log()
      }
    }
  }

  func newArticleSelected(indexPath anIndexPath: IndexPath) {
    let theIndex = anIndexPath.row
    guard let theArticles = _articles, theIndex < theArticles.count else {
      currentArticle = nil
      return
    }
    currentArticle = theArticles[theIndex]
  }

  func requestDataForSharing() {
    guard let theUrl = currentArticle?.url else {
      return
    }
    view.showShareDialog(data: [theUrl])
  }

  func showWeb() {
    guard let theUrl = currentArticle?.url else {
      return
    }
    view.navigationController?.pushViewController(WebViewerRouter.shared.defaultVc(url: theUrl), animated: true)
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
