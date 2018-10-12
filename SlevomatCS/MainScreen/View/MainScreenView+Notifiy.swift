//
// Created by Jan Kase on 2018-10-12.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import UIKit

extension MainScreenView {

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

  func updateCurrentImage(_ aCurrentImage: UIImage?) {
    DispatchQueue.main.async {
      self.currentPreview.image = aCurrentImage
    }
  }

  func updateCurrentTitle(_ aCurrentTitle: String?) {
    DispatchQueue.main.async {
      self.currentTitle.text = aCurrentTitle
    }
  }

  func updateCurrentDescription(_ aCurrentDescription: String?) {
    DispatchQueue.main.async {
      self.currentDescription.text = aCurrentDescription
    }
  }

  func updateCurrentAuthorNameAndPublishDate(_ aCurrentAuthorNameAndPublishDate: String?) {
    DispatchQueue.main.async {
      self.currentAuthorAndDate.text = aCurrentAuthorNameAndPublishDate
    }
  }

  func showShareButton() {
    guard navigationItem.rightBarButtonItem == nil else {
      return
    }
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                        target: self,
                                                        action: #selector(shareCurrentArticle))
  }

  func hideShareButton() {
    navigationItem.rightBarButtonItem = nil
  }

}
