//
// Created by Jan Kase on 2018-10-12.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import RealmSwift

extension LocalDb {

  static func migrateToSchema3(_ aMigration: Migration) {
    aMigration.enumerateObjects(ofType: Article.className()) { anOldObject, aNewObject in
      guard let theOldObject = anOldObject, let theNewObject = aNewObject else {
        return
      }
      if let theImageUrlString = theOldObject["internalImageUrl"] as? String,
         let theImageUrl = URL(string: theImageUrlString) {
        theNewObject["imageData"] = try? Data(contentsOf: theImageUrl)
      }
    }
  }

}
