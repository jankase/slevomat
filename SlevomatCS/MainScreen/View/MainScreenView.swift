//
// Created by Jan Kase on 2018-10-11.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import SnapKit
import UIKit

class MainScreenView: UIViewController {

  static var articleCellIdentifier = "ArticleCell"

  weak var headerContainer: UIView!
  weak var table: UITableView!

  weak var currentTitle: UILabel!
  weak var currentDescription: UILabel!
  weak var currentAuthor: UILabel!
  weak var currentPublishAt: UILabel!
  weak var currentPreview: UIImage!

  var presenter: MainScreenPresenter!

  override func loadView() {
    view = UIView(frame: UIScreen.main.bounds)
    view.backgroundColor = .white
    _loadHeader()
    _loadTable()
    _loadSharingButton()
    presenter.loadArticles()
  }

  func shouldReloadArticles() {
    DispatchQueue.main.async {
      self.table?.reloadData()
    }
  }

  func performUpdates(deletions aDeletions: [IndexPath],
                      insertion anInsertion: [IndexPath],
                      updates anUpdates: [IndexPath]) {
    DispatchQueue.main.async {
      self.table.beginUpdates()
      self.table.deleteRows(at: aDeletions, with: .automatic)
      self.table.insertRows(at: anInsertion, with: .automatic)
      self.table.reloadRows(at: anUpdates, with: .automatic)
      self.table.endUpdates()
    }
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

  private func _loadSharingButton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                        target: self,
                                                        action: #selector(_share))
  }

  @objc
  private func _share() {
  }

}
