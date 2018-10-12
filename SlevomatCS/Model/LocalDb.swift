//
// Created by Jan Kase on 2018-10-10.
// Copyright (c) 2018 Jan Kaše. All rights reserved.
//

import Foundation
import RealmSwift

struct LocalDb {

  static var configuration: Realm.Configuration = {
    let theResult = Realm.Configuration(schemaVersion: 3,
                                        migrationBlock: { aMigration, anOldSchemaVersion in
                                          if anOldSchemaVersion < 3 { migrateToSchema3(aMigration) }
                                        },
                                        shouldCompactOnLaunch: { aTotalSize, aUsedSize in
                                          guard (aTotalSize - aUsedSize) > 1_048_576 else {
                                            return false
                                          }
                                          let theRatio = Double(aUsedSize) / Double(aTotalSize)
                                          return theRatio < 0.8
                                        })
    "Realm DB path: \(String(describing: theResult.fileURL?.path))".log()
    return theResult
  }()

  static func realm() throws -> Realm {
    do {
      return try Realm(configuration: configuration)
    } catch let theError as Error {
      "Failed to open local DB: \(theError)".log()
      throw theError
    }
  }

}
