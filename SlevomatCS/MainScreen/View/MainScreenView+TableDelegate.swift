//
// Created by Jan Kase on 2018-10-12.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import UIKit

extension MainScreenView: UITableViewDelegate {

  public func tableView(_ aTableView: UITableView, didSelectRowAt anIndexPath: IndexPath) {
    aTableView.deselectRow(at: anIndexPath, animated: true)
    presenter.newArticleSelected(indexPath: anIndexPath)
  }

}
