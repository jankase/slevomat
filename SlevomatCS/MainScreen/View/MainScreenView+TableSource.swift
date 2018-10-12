//
// Created by Jan Kase on 2018-10-12.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import SnapKit
import UIKit

extension MainScreenView: UITableViewDataSource {

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard section == 0 else {
      fatalError("table has only one section")
    }
    return presenter.numberOfArticles
  }

  public func tableView(_ aTableView: UITableView, cellForRowAt anIndexPath: IndexPath) -> UITableViewCell {
    var theCell = aTableView.dequeueReusableCell(withIdentifier: MainScreenView.articleCellIdentifier)
    if theCell == nil {
      theCell = UITableViewCell(style: .subtitle, reuseIdentifier: MainScreenView.articleCellIdentifier)
      theCell!.textLabel?.numberOfLines = 0
      theCell!.textLabel?.lineBreakMode = .byWordWrapping
    }
    theCell!.textLabel?.text = presenter.title(indexPath: anIndexPath)
    theCell!.detailTextLabel?.text = presenter.listDate(indexPath: anIndexPath)
    if let theImage = presenter.listImage(indexPath: anIndexPath) {
      theCell!.imageView?.image = theImage
    }
    return theCell!
  }

}
