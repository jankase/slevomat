//
// Created by Jan Kase on 2018-10-11.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import SnapKit
import UIKit

class MainScreenView: UIViewController {

  static var articleCellIdentifier = "ArticleCell"
  static var border: CGFloat = 10
  static var labelSpacing: CGFloat = 5

  weak var headerContainer: UIView!
  weak var table: UITableView!

  weak var currentTitle: UILabel!
  weak var currentDescription: UILabel!
  weak var currentAuthorAndDate: UILabel!
  weak var currentPreview: UIImageView!

  var presenter: MainScreenPresenter!

  override func loadView() {
    view = UIView(frame: UIScreen.main.bounds)
    view.backgroundColor = .white
    _loadHeader()
    _loadTable()
    presenter.loadArticles()
  }

  private func _loadHeader() {
    let theContainer = UIView()
    view.addSubview(theContainer)
    theContainer.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.left.equalToSuperview()
      $0.right.equalToSuperview()
    }
    headerContainer = theContainer
    _loadCurrentPreview()
    _loadCurrentTitle()
    _loadCurrentAuthorAndDate()
    _loadCurrentDescription()
  }

  private func _loadCurrentPreview() {
    let thePreview = UIImageView()
    thePreview.contentMode = .scaleAspectFit
    headerContainer.addSubview(thePreview)
    thePreview.snp.makeConstraints {
      $0.top.equalToSuperview().inset(MainScreenView.border)
      $0.left.equalToSuperview().inset(MainScreenView.border)
      $0.width.equalToSuperview().dividedBy(3)
      $0.height.equalTo(thePreview.snp.width)
      $0.bottom.equalToSuperview().inset(MainScreenView.border).priority(.low)
    }
    currentPreview = thePreview
  }

  private func _loadCurrentTitle() {
    let theTitle = UILabel()
    theTitle.font = .preferredFont(forTextStyle: .body)
    theTitle.numberOfLines = 0
    theTitle.lineBreakMode = .byWordWrapping
    headerContainer.addSubview(theTitle)
    theTitle.snp.makeConstraints {
      $0.top.equalToSuperview().inset(MainScreenView.border)
      $0.right.equalToSuperview().inset(MainScreenView.border)
      $0.left.equalTo(currentPreview.snp.right).offset(MainScreenView.border)
    }
    currentTitle = theTitle
  }

  private func _loadCurrentAuthorAndDate() {
    let theAuthor = UILabel()
    theAuthor.font = .preferredFont(forTextStyle: .caption1)
    theAuthor.lineBreakMode = .byWordWrapping
    theAuthor.numberOfLines = 0
    headerContainer.addSubview(theAuthor)
    theAuthor.snp.makeConstraints {
      $0.top.equalTo(currentTitle.snp.bottom)
      $0.left.equalTo(currentPreview.snp.right).offset(MainScreenView.border)
      $0.right.equalToSuperview().inset(MainScreenView.border)
    }
    currentAuthorAndDate = theAuthor
  }

  private func _loadCurrentDescription() {
    let theDescription = UILabel()
    theDescription.font = .preferredFont(forTextStyle: .caption1)
    theDescription.numberOfLines = 5
    theDescription.lineBreakMode = .byTruncatingTail
    headerContainer.addSubview(theDescription)
    theDescription.snp.makeConstraints {
      $0.left.equalTo(currentPreview.snp.right).offset(MainScreenView.border)
      $0.right.equalToSuperview().inset(MainScreenView.border)
      $0.top.equalTo(currentAuthorAndDate.snp.bottom).offset(MainScreenView.labelSpacing)
      $0.bottom.equalToSuperview().inset(MainScreenView.border).priority(.low)
    }
    currentDescription = theDescription
  }

  private func _loadTable() {
    let theResult = UITableView()
    view.addSubview(theResult)
    theResult.snp.makeConstraints {
      $0.top.equalTo(headerContainer.snp.bottom)
      $0.left.equalToSuperview()
      $0.right.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
    theResult.delegate = self
    theResult.dataSource = self
    table = theResult
  }

  @objc
  func shareCurrentArticle() {
    presenter.requestDataForSharing()
  }

}
